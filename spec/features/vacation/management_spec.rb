require 'rails_helper'

feature 'Admin can accept or reject vacation requests', %q{
  In order to control the amount of all vacations
  As an admin
  I'd like to be able to accept or reject vacation requests
} do

  given(:employee)   { create(:employee) }
  given!(:vacation)  { create(:vacation, employee: employee) }
  given(:admin)      { create(:employee, admin: true) }
  
  scenario 'Admin accepts vacation request; Employee sees a change status' do
    Capybara.using_session('admin') do
      sign_in_employee(admin)
      click_on 'Vacations'

      within "#vacation_#{vacation.id}" do
        click_on 'Accept'  
        
        expect(page).to_not have_content('received')
        expect(page).to_not have_link('Accept')
        expect(page).to have_content('accepted')
        expect(page).to have_content("Admined by: #{admin.email}")
      end      
    end

    Capybara.using_session('employee') do
      sign_in_employee(employee)
      click_on 'My profile'

      within "#vacation_#{vacation.id}" do
        expect(page).to have_content('accepted')
      end 
    end
  end

  # Same as accept 
  scenario 'Admin reject vacation request; Employee sees a change status' do
    Capybara.using_session('admin') do
      sign_in_employee(admin)
      click_on 'Vacations'

      within "#vacation_#{vacation.id}" do
        click_on 'Reject'

        expect(page).to_not have_content('received')
        expect(page).to_not have_link('Reject')
        expect(page).to have_content('rejected')
        expect(page).to have_content("Admined by: #{admin.email}")
      end      
    end

    Capybara.using_session('employee') do
      sign_in_employee(employee)
      click_on 'My profile'

      within "#vacation_#{vacation.id}" do
        expect(page).to have_content('rejected')
      end 
    end
  end
end
