FactoryGirl.define do
  factory :event do
    level { Constants::Levels::SILVER }
    competition
    sequence(:number)
  end
end
