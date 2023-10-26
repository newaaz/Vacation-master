class EmployeesController < ApplicationController
  def show
    @employee = Employee.includes(:vacations).find(params[:id])
    authorize @employee
  end

  private

  def pundit_user
    current_employee
  end
end
