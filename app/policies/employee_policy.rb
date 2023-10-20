class EmployeePolicy < ApplicationPolicy
  def show?
    record == user
  end
end
