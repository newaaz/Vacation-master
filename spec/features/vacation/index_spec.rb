require 'rails_helper'

describe 'Admin can view the list of vacation requests', "
  In order to accept and reject a vacation requests
  As an admin
  I'd like to be able to to a list of all vacations
" do
  let!(:vacations) { create_list(:vacation, 3) }
  let(:admin)      { create(:employee, admin: true) }
  let(:employee)   { create(:employee) }

  it 'Authenticated admin view list of all vacations' do
    sign_in_employee(admin)
    click_on 'Vacations'

    vacations.each do |vacation|
      expect(page).to have_link("Vacation request № #{vacation.id}")
      expect(page).to have_content("#{vacation.employee.full_name} - from: #{vacation.start_date} to: #{vacation.end_date}")
    end
  end

  it 'Authenticated employee tries to view list of all vacations' do
    sign_in_employee(employee)
    visit root_path
    expect(page).not_to have_link('Vacations')
  end

  it 'Unauthenticated user tries to view list of all vacations' do
    visit root_path
    expect(page).not_to have_link('Vacations')
  end
end
