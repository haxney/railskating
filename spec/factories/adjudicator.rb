FactoryGirl.define do
  factory :adjudicator do
    user
    competition
    shorthand 'J'
  end

  factory :random_adjudicator, parent: :adjudicator do
    association :user, factory: :random_user
    association :competition, factory: :random_competition
    shorthand { Forgery(:basic).text exactly: 1, allow_lower: false }
  end
end
