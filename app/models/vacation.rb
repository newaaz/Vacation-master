class Vacation < ApplicationRecord
  STATUS_ACTIONS = { accept: :accept_vacation, reject: :reject_vacation }.freeze

  include Statusable

  belongs_to :employee
  belongs_to :admined_by, class_name: "Employee", optional: true

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  after_create :send_notification_created
  after_update :send_notification_changed

  private

  # send by service
  def send_notification_created
    VacationCreatedNotifyService.new.send_notify(self)
  end

  def send_notification_changed
    VacationMailer.vacation_changed_status(self).deliver_now
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    return unless end_date < start_date

    errors.add(:end_date, "must be after the start date")
  end
end
