module FeatureHelpers
  def sign_in_employee(employee)
    visit new_employee_session_path
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    click_button 'Log in'
  end
end
