require 'rails_helper'

feature 'Employee can logout', %q{
  In order to logout from system
  As an authenticated Employee
  I'd like to be able to logout
} do

  given(:employee) { create(:employee) }

  scenario 'Authenticated employee tries logout' do
    sign_in_employee(employee)
    click_on 'Sign Out'
    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'Unauthenticated employee tries log out' do
    visit root_path
    expect(page).to_not have_content 'Sign Out'      
  end
end
