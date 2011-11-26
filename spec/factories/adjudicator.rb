FactoryGirl.define do
  factory :adjudicator do
    user
    competition
    sequence(:shorthand) { |n| ('A'..'Z').to_a[n] }
  end
end
