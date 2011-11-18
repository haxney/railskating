FactoryGirl.define do
  factory :adjudicator do
    user
    competition
    sequence(:shorthand) { |n| ('A'..'Z').to_a[n] }
  end

  factory :random_adjudicator, parent: :adjudicator do
    association :user, factory: :random_user
    association :competition, factory: :random_competition
    sequence(:shorthand)
  end
end
