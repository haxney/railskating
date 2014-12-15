FactoryGirl.define do
  factory :sub_event do
    transient do
      event
      dance { Constants::Dances::AMERICAN_MAMBO }
    end
    sequence(:weight)
    initialize_with do
      SubEvent.find_or_create_by(event: event,
                                 dance: dance)
    end

  end
end
