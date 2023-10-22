require 'rails_helper'

feature 'Admin can accept or reject vacation requests', %q{
  In order to control the amount of all vacations
  As an admin
  I'd like to be able to accept or reject vacation requests
} do

  given(:employee)   { create(:employee) }
  given!(:vacation)  { create(:vacation, employee: employee) }
  given(:admin)      { create(:employee, admin: true) }
  
  scenario 'Admin accepts vacation request (multiple_sessions)' do
    Capybara.using_session('admin') do
      sign_in_employee(admin)
      click_on 'Vacations'

      within "#vacation_#{vacation.id}" do
        click_on 'Accept'        
        expect(page).to have_content('accepted')
      end

      



      
    end
  end
  
end


