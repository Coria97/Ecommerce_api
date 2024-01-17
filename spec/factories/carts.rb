FactoryBot.define do
  factory :cart do
    association :created_by, factory: :user
    status { Faker::Number.between(from: 0, to: 3) }
  end
end
