FactoryGirl.define do
  # Non-final round
  factory :round do
    event
    sequence(:number)
    final false
    requested 6
    cutoff 4
  end
end
