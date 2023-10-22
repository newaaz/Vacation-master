class Employee < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :vacations, dependent: :destroy
  has_many :admined_vacations, class_name: "Vacation", foreign_key: "admined_by_id"    
end
