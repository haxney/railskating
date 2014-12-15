FactoryGirl.define do
  factory :adjudicator do
    user
    transient do
      competition
      sequence(:shorthand, 'A')
    end

    initialize_with do
      Adjudicator.find_or_create_by(competition: competition,
                                    shorthand: shorthand)
    end
  end
end
