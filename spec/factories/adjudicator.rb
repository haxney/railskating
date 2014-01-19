FactoryGirl.define do
  factory :adjudicator do
    user
    competition
    # First argument passed in is 1, so we need to start one code point before
    # 'A', which is '@'.
    sequence(:shorthand) { |n| ('@'..'Z').to_a[n] }
  end
end
