class VacationsController < ApplicationController
  before_action :authorize_vacation!, except: :show
  before_action :set_vacation, only: [:show]

  after_action  :verify_authorized, except: :show

  def index
    @vacations = Vacation.all
  end

  def show
    authorize(@vacation)
  end

  def new
    @vacation = Vacation.new
  end

  def create
    @vacation = current_employee.vacations.build(vacation_params)
    
    if @vacation.save
      flash[:success] = "Vacation request sent successfully"
      redirect_to @vacation
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def vacation_params
    params.require(:vacation).permit(:start_date, :end_date)
  end

  def set_vacation
    @vacation = Vacation.find(params[:id])
  end

  def pundit_user
    current_employee
  end

  def authorize_vacation!
    authorize(@vacation || Vacation)
  end
end
