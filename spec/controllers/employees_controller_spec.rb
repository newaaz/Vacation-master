require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  let(:admin)      { create(:employee, admin: true) }
  let(:employee)   { create(:employee) }
  let!(:vacations) { create_list(:vacation, 3, employee:) }

  describe 'GET #show' do
    context 'Authenticated employee' do
      before do
        sign_in(employee)
        get(:show, params: { id: employee })
      end

      it 'assigns requested employee to @employee' do
        expect(assigns(:employee)).to eq employee
      end

      it 'render new show' do
        expect(response).to render_template :show
      end
    end

    context "Unauthenticated user is trying to access the employee's page" do
      it 'redirect to root path' do
        get(:show, params: { id: employee })
        expect(response).to redirect_to root_path
      end
    end

    context "Admin is trying to access the employee's page" do
      it 'redirect to root path' do
        sign_in(admin)
        get(:show, params: { id: employee })
        expect(response).to redirect_to root_path
      end
    end
  end
end
