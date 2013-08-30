FactoryGirl.define do
  factory :couple do
    association :lead, factory: :user
    association :follow, factory: :user
    event
    sequence(:number)
  end
end
