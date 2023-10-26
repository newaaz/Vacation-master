require 'rails_helper'

RSpec.describe VacationsController, type: :controller do
  let(:admin)    { create(:employee, admin: true) }
  let(:employee) { create(:employee) }
  let(:vacation) { create(:vacation, employee:) }
  let(:vacation_other) { create(:vacation, employee: admin) }

  describe 'PATCH #update' do
    context 'Admin accept request vacation' do
      before do
        sign_in(admin)
        patch :update, params: { id: vacation, status_action: 'accept' }
        vacation.reload
      end

      it 'changed status to accepted' do
        expect(vacation.status).to eq 'accepted'
      end

      it 'request vacation admined by curretn admin' do
        expect(vacation.admined_by).to eq admin
      end
    end

    context 'Admin changes request vacation with wrong status_action' do
      before do
        sign_in(admin)
        patch :update, params: { id: vacation, status_action: 'wrong_status_action' }
        vacation.reload
      end

      it_behaves_like 'Vacation status still: received'
      it_behaves_like 'Redirect to root'
    end

    context 'Admin changes status of a vacation when it has already been accepted' do
      before do
        vacation.accepted!
        sign_in(admin)
        patch :update, params: { id: vacation, status_action: 'reject' }
      end

      it 'not changed vacation status' do
        expect(vacation.status).to eq 'accepted'
      end

      it_behaves_like 'Redirect to root'
    end

    context 'Authencticated Employee tries accept request vacation' do
      before do
        sign_in(employee)
        patch :update, params: { id: vacation, status_action: 'accept' }
        vacation.reload
      end

      it_behaves_like 'Vacation status still: received'
      it_behaves_like 'Redirect to root'
    end

    context 'Unauthencticated user tries accept request vacation' do
      before do
        patch :update, params: { id: vacation, status_action: 'accept' }
        vacation.reload
      end

      it_behaves_like 'Vacation status still: received'
      it_behaves_like 'Redirect to root'
    end

    # Reject - same as accept
  end

  describe 'GET #new' do
    context 'Authenticated employee' do
      before do
        sign_in(employee)
        get :new
      end

      it 'assigns a new Vacation to @vacation' do
        expect(assigns(:vacation)).to be_a_new(Vacation)
      end

      it 'render new view' do
        expect(response).to render_template :new
      end
    end

    context 'Unauthenticated employee' do
      before { get :new }

      it_behaves_like 'Redirect to root'
    end
  end

  describe 'POST #create' do
    context 'Authenticated employee' do
      before { sign_in(employee) }

      context 'create vacation with valid attributes' do
        it 'saves new order in DB' do
          expect { post :create, params: { vacation: attributes_for(:vacation) } }.to change(Vacation, :count).by(1)
        end

        it 'redirect to vacation path' do
          post :create, params: { vacation: attributes_for(:vacation) }
          expect(response).to redirect_to assigns(:vacation)
        end
      end

      context 'create vacation with invalid attributes' do
        it 'does not saves new order in DB' do
          expect { post :create, params: { vacation: attributes_for(:vacation, start_date: nil, end_date: nil) } }
            .not_to change(Vacation, :count)
        end

        it 're-renders new view' do
          post :create, params: { vacation: attributes_for(:vacation, start_date: nil, end_date: nil) }
          expect(response).to render_template :new
        end
      end

      context 'create vacation with end_date earlier start_date' do
        it 'does not saves new order in DB' do
          expect do
            post :create,
                 params: { vacation: attributes_for(:vacation, start_date: Time.zone.now,
                                                               end_date: 20.days.ago) }
          end
            .not_to change(Vacation, :count)
        end

        it 're-renders new view' do
          post :create,
               params: { vacation: attributes_for(:vacation, start_date: Time.zone.now,
                                                             end_date: 20.days.ago) }
          expect(response).to render_template :new
        end
      end
    end

    context 'Unauthenticated employee create vacation' do
      it 'does not saves new order in DB' do
        expect { post :create, params: { vacation: attributes_for(:vacation) } }.not_to change(Vacation, :count)
      end

      it 'redirect to root path' do
        post :create, params: { vacation: attributes_for(:vacation) }
        expect(response).to redirect_to root_path
      end
    end
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

      it_behaves_like 'Redirect to root'
    end

    context 'Unauthenticated user' do
      it 'not renders index view' do
        get :index
        expect(response).not_to render_template :index
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
        expect(response).not_to render_template :show
      end
    end

    context "Admin looks at employees vacation" do
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
        expect(response).not_to render_template :show
      end
    end
  end
end
