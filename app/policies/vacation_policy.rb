class VacationPolicy < ApplicationPolicy
  def index?
    user&.admin?
  end

  def show?
    record.employee == user || user&.admin?
  end

  def create?
    !!user
  end

  def accept_vacation?
    can_changed_from_received?
  end

  def reject_vacation?
    can_changed_from_received?
  end

  private

  def can_changed_from_received?
    user&.admin? && record.status == "received"
  end
end
