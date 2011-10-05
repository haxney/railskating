FactoryGirl.define do
  factory :sub_round do
    round
    sub_event
  end

  factory :random_sub_round, parent: :sub_round do
    association :round, factory: :random_round
    association :sub_event, factory: :random_sub_event
  end
end
