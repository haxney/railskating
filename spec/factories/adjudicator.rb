FactoryGirl.define do
  factory :adjudicator do
    user
    competition
    sequence(:shorthand, 'A')
  end
end
