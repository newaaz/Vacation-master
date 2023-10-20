require 'rails_helper'

feature 'Employee may request a vacation', %q{
  In order to book a vacation
  As an authenticated employee
  I'd like to be able to create a vacation request
} do

  given(:employee) { create(:employee) }

  describe 'Authenticated employee create vacation' do  
    background do
      sign_in_employee(employee)
      visit root_path
      click_on 'Request vacation'
    end

    scenario 'with valid attributes' do
      fill_in 'vacation_start_date', with: '14.06.2024'
      fill_in 'vacation_end_date', with: '03.07.2024'
      click_button 'Request vacation'

      vacation = Vacation.last

      expect(page).to have_content "Vacation № #{vacation.id} request sent successfully"
      expect(page).to have_content "#{vacation.id} from #{vacation.start_date} to #{vacation.end_date}"
    end

    scenario 'with invalid attributes' do
      click_button 'Request vacation'

      expect(page).to have_content "Start date can't be blank"
      expect(page).to have_content "End date can't be blank"
    end

    scenario 'with end_date earlier start_date' do
      fill_in 'vacation_start_date', with: '14.06.2024'
      fill_in 'vacation_end_date', with: '03.07.2020'
      click_button 'Request vacation'

      expect(page).to have_content "End date must be after the start date"
    end
  
  end

  scenario 'Unauthenticated employee create vacation' do
    visit root_path

    expect(page).to_not have_link'Request vacation'
    expect(page).to have_link 'Log in'
  end
end
