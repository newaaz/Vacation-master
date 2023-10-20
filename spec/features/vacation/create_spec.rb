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

      expect(page).to have_content "Vacation №-#{Vacation.last.id}"
    end

    scenario 'with invalid attributes' do

    end

    scenario 'with end_date earlier start_date' do
    end
  
  end

  describe 'Unauthenticated employee create vacation' do
    scenario 'try to create vacation' do
      
    end
  end

end
