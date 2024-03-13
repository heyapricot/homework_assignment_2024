FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    employee_count { rand(1..999) }
    industry { Faker::Company.industry }
  end
end
