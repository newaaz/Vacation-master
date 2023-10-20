FactoryBot.define do
  factory :employee do
    sequence(:email) { |n| "employee_#{n}@test.com" }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
