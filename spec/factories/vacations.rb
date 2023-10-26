FactoryBot.define do
  factory :vacation do
    employee   { association :employee }
    start_date { "2024-06-05" }
    end_date   { "2024-07-09" }

    trait :invalid do
      start_date  { nil }
      end_date    { nil }
    end
  end
end
