require 'rails_helper'

RSpec.describe VacationsController, type: :controller do

let(:admin)    { create :employee, admin: true}
let(:employee) { create :employee}
let(:vacation) { create :vacation, employee: employee}
let(:vacation_other) { create :vacation, employee: admin}

  describe 'GET #new' do
    context 'Authenticated employee' do
      before { sign_in(employee) }

      before { get :new }

      it 'assigns a new Vacation to @vacation' do
        expect(assigns(:vacation)).to be_a_new(Vacation)
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

  describe 'GET #index' do
    let(:vacations) { create_list(:vacation, 3) }

    context 'Authenticated admin' do
      before do
        sign_in(admin)
        get :index
      end

      it 'populates an array of all vacations' do         
        expect(assigns(:vacations)).to match_array(vacations)
      end

      it 'renders index view' do
        expect(response).to render_template :index
      end
    end

    context 'Authenticated employee' do
      before do
        sign_in(employee)
        get :index
      end

      it 'not renders index view' do
        expect(response).to_not render_template :index
      end
    end

    context 'Unauthenticated user' do
      it 'not renders index view' do
        get :index
        expect(response).to_not render_template :index
      end
    end
  end

  describe 'GET #show' do
    context 'Authenticated employee views his vacation' do
      before do
        sign_in(employee)
        get :show, params: { id: vacation }
      end

      it 'assigns requested vacation to vacation' do
        expect(assigns(:vacation)).to eq vacation
      end

      it 'render show view' do
        expect(response).to render_template :show
      end
    end

    context "Authenticated employee looks at someone else's vacation" do
      before do
        sign_in(employee)
        get :show, params: { id: vacation_other }
      end

      it 'not render show view' do
        expect(response).to_not render_template :show
      end
    end

    context "Adminlooks at employees vacation" do
      before do
        sign_in(admin)
        get :show, params: { id: vacation }
      end

      it 'assigns requested vacation to vacation' do
        expect(assigns(:vacation)).to eq vacation
      end

      it 'render show view' do
        expect(response).to render_template :show
      end
    end

    context "Unauthenticated user looks at vacation" do
      it 'not render show view' do
        get :show, params: { id: vacation_other }
        expect(response).to_not render_template :show
      end
    end
  end
end
