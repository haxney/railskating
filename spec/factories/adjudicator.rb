FactoryGirl.define do
  factory :adjudicator do
    user
    ignore do
      competition
      sequence(:shorthand, 'A')
    end

    initialize_with do
      Adjudicator.find_or_create_by(competition: competition,
                                    shorthand: shorthand)
    end
  end
end
