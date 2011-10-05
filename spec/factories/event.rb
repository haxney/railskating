FactoryGirl.define do
  factory :event do
    level
    competition
  end

  factory :random_event, parent: :event do
    association :level, factory: :random_level
    association :competition, factory: :random_competition
  end
end