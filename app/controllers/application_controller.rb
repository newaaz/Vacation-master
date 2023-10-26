class ApplicationController < ActionController::Base
  include Authorized

  private

  def after_sign_in_path_for(resource)
    current_employee.admin? ? vacations_path : employee_path(current_employee)
  end
end
