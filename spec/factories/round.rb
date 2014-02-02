FactoryGirl.define do
  factory :round do
    final false
    requested 6
    cutoff nil

    ignore do
      event
      sequence(:number)
    end

    initialize_with do
      Round.find_or_create_by(event: event,
                              number: number)
    end
  end
end
