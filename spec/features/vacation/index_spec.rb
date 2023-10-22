require 'rails_helper'

feature 'Admin can view the list of vacation requests', %q{
  In order to accept and reject a vacation requests
  As an admin
  I'd like to be able to to a list of all vacations
} do

  given!(:vacations) { create_list(:vacation, 3) }
  given(:admin)      { create(:employee, admin: true) }
  given(:employee)   { create(:employee) }

  scenario 'Authenticated admin view list of all vacations' do
    sign_in_employee(admin)
    click_on 'Vacations'

    vacations.each do |vacation|
      expect(page).to have_link("Vacation request № #{vacation.id}")
      expect(page).to have_content("#{vacation.employee.full_name} - from: #{vacation.start_date} to: #{vacation.end_date}")
    end
  end

  scenario 'Authenticated employee tries to view list of all vacations' do
    sign_in_employee(employee)
    visit root_path
    expect(page).to_not have_link('Vacations')
  end

  scenario 'Unauthenticated user tries to view list of all vacations' do
    visit root_path
    expect(page).to_not have_link('Vacations')
  end
end
