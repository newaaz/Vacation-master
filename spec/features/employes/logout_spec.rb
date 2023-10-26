require 'rails_helper'

describe 'Employee can logout', "
  In order to logout from system
  As an authenticated Employee
  I'd like to be able to logout
" do
  let(:employee) { create(:employee) }

  it 'Authenticated employee tries logout' do
    sign_in_employee(employee)
    click_on 'Sign Out'
    expect(page).to have_content 'Signed out successfully.'
  end

  it 'Unauthenticated employee tries log out' do
    visit root_path
    expect(page).not_to have_content 'Sign Out'
  end
end
