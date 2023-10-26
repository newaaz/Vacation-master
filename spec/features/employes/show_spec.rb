require 'rails_helper'

describe 'Employee can see their vacation requests', "
  In order to see status their vacation requests
  As an authenticated employee
  I'd like to be able to all my vacation requests
" do
  let(:employee)   { create(:employee) }
  let!(:vacations) { create_list(:vacation, 3, employee:) }

  describe 'Authenticated employee visits his profile' do
    it 'and sees his vacation requests' do
      sign_in_employee(employee)
      click_on 'My profile'

      vacations.each do |vacation|
        expect(page).to have_link("Vacation request № #{vacation.id}")
        expect(page).to have_content("from #{vacation.start_date} to #{vacation.end_date}")
      end
    end
  end
end
