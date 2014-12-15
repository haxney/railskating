FactoryGirl.define do
  factory :team do
    transient { name "Brown University" }
    initialize_with { Team.find_or_create_by(name: name) }
  end
end
