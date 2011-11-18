FactoryGirl.define do
  factory :sub_event do
    event
    dance { Constants::Dances::AMERICAN_MAMBO }
    order 1
  end

  factory :random_sub_event, parent: :sub_event do
    association :event, factory: :random_event
    dance { Constants::Dances::DANCES.sample }
    order { Forgery(:basic).number at_least: 1, at_most: 5 }
  end
end
