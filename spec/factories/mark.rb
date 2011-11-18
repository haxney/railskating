FactoryGirl.define do
  factory :mark do
    adjudicator
    sub_round
    couple
    placement 0
  end

  factory :random_mark, parent: :mark do
    association :adjudicator, factory: :random_adjudicator
    association :sub_round, factory: :random_sub_round
    association :couple, factory: :random_couple
  end
end
