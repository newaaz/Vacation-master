class Vacation < ApplicationRecord
  belongs_to :employee
  belongs_to :admin, class_name: "Employee", optional: true

  validates :start_date, :end_date, :status,  presence: true
end
