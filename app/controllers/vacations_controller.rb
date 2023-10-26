class VacationsController < ApplicationController
  before_action :authorize_vacation!, except: %i[show update]
  before_action :set_vacation, only: %i[show update]

  after_action  :verify_authorized, except: %i[show update]

  def index
    @vacations = Vacation.all
  end

  def show
    authorize(@vacation)
  end

  def new
    @vacation = Vacation.includes(%i[employee admined_by]).new
  end

  def create
    @vacation = current_employee.vacations.build(vacation_params)

    if @vacation.save
      flash[:success] = "Vacation № #{@vacation.id} request sent successfully"
      redirect_to @vacation
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    if status_action_exist?(params[:status_action])
      authorize(@vacation, authorized_action(params[:status_action]))

      @vacation.update(status: "#{params[:status_action]}ed", admined_by: current_employee)

      respond_to do |format|
        format.html { redirect_back fallback_location: root_path }
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.replace(@vacation, partial: 'vacations/vacation', locals: { vacation: @vacation })
        end
      end
    else
      redirect_to root_path, flash: { error: 'Wrong action' }
    end
  end

  private

  def status_action_exist?(status_action)
    Vacation::STATUS_ACTIONS.key?(status_action.to_sym)
  end

  def authorized_action(status_action)
    "#{status_action}_vacation?".to_sym
  end

  def vacation_params
    params.require(:vacation).permit(:start_date, :end_date)
  end

  def set_vacation
    @vacation = Vacation.includes(%i[employee admined_by]).find(params[:id])
  end

  def pundit_user
    current_employee
  end

  def authorize_vacation!
    authorize(@vacation || Vacation)
  end
end
