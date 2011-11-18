FactoryGirl.define do
  factory :couple do
    association :lead, factory: :user
    association :follow, factory: :user
    event
    sequence(:number)
  end

  factory :random_couple, parent: :couple do
    association :lead, factory: :random_user
    association :follow, factory: :random_user
    association :event, factory: :random_event
    sequence(:number)
  end
end
