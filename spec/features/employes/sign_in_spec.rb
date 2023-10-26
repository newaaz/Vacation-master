require 'rails_helper'

describe 'Employee can sign in', "
  In order to create a leave request
  As an unauthenticated employee
  I'd like to be able to sign in
" do
  let(:employee) { create(:employee) }

  before { visit new_employee_session_path }

  it 'Registered Employee tries to sign in' do
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    click_button 'Log in'

    expect(page).to have_content 'Signed in successfully'
  end

  it 'Unregistered (or with wrong email/password) Employee tries to sign up' do
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: 'wrong'
    click_button 'Log in'

    expect(page).to have_content 'Invalid Email or password'
  end
end
