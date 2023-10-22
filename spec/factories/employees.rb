FactoryBot.define do
  factory :employee do
    sequence(:email) { |n| "employee_#{n}@test.com" }
    full_name        { 'Test Employee' }
    password         { '12345678' }
    password_confirmation { '12345678' }
  end
end
