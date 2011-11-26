FactoryGirl.define do
  factory :sub_event do
    event
    dance { Constants::Dances::AMERICAN_MAMBO }
    order 1
  end
end
