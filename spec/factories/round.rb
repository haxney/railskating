FactoryGirl.define do
  # Non-final round
  factory :round do
    event
    sequence(:number)
    final false
    requested 6
    cutoff 4
  end

  # Non-final round
  factory :random_round, parent: :round do
    association :event, factory: :random_event
    number { Forgery(:basic).number at_least: 1, at_most: 8 }
  end
end
