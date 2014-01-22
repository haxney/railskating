FactoryGirl.define do
  factory :sub_event do
    event
    dance { Constants::Dances::AMERICAN_MAMBO }
    sequence(:weight)
  end
end
