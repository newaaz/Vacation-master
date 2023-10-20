require 'rails_helper'

RSpec.describe VacationsController, type: :controller do

let(:employee) { create :employee}

  describe 'GET #new' do
    context 'Authenticated employee' do
      before { sign_in(employee) }

      before { get :new }

      it 'assigns a new Vacation to @vacation' do
        expect(assigns(:vacation)).to be_a_new(vacation)
      end

      it 'render new view' do
        expect(response).to render_template :new
      end
    end

    context 'Unauthenticated employee' do
      before { get :new }

      it 'redirect to root path' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST #create' do
    
  end


end
