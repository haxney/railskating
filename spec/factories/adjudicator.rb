FactoryGirl.define do
  factory :adjudicator do
    user
    competition
    shorthand 'J'
  end

  factory :random_adjudicator, parent: :adjudicator do
    association :user, factory: :random_user
    association :competition, factory: :random_competition
    sequence(:shorthand)
  end
end
