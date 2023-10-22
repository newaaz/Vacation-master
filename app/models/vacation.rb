class Vacation < ApplicationRecord
  include AASM

  belongs_to :employee
  belongs_to :admined_by, class_name: "Employee", optional: true

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  #TODO: move to concern?
  enum status: { received: 0, accepted: 1, rejected: 2 }

  aasm column: :status, enum: true do
    state :received, initial: true
    state :accepted, :rejected

    event :accept do
      transitions from: :received, to: :accepted
    end

    event :reject do
      transitions from: :received, to: :rejected
    end
  end

  def change_status(status_action)
    case  status_action
      when 'accept'
        accept_vacation!
      when 'reject'
        reject_vacation!
      end  
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  def accept_vacation!
    self.accepted!
  end

  def reject_vacation!
    self.rejected!
  end
end
