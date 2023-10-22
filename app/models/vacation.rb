class Vacation < ApplicationRecord
  include Statusable

  belongs_to :employee
  belongs_to :admined_by, class_name: "Employee", optional: true

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  #after_create :send_notifications

  private

  def send_notifications
    VacationCreatedNotifyService.send_notify(self)
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
