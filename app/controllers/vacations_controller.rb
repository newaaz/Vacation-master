class VacationsController < ApplicationController
  before_action :authorize_vacation!, except: :show
  before_action :set_vacation, only: [:show]

  after_action  :verify_authorized, except: :show

  def index
    @vacations = Vacation.all
  end

  def show
    @vacation = Vacation.find(params[:id])
    authorize(@vacation)
  end

  def new
    @vacation = Vacation.new
  end

  private

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
