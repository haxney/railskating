FactoryGirl.define do
  factory :couple do
    association :lead, factory: :user
    association :follow, factory: :user

    ignore do
      event
      sequence(:number)
    end

    initialize_with do
      Couple.find_or_create_by(event: event,
                               number: number)
    end
  end
end
