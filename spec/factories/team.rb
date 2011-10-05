FactoryGirl.define do
  factory :team do
    name "Brown University"
  end

  factory :random_team, parent: :team do
    name { Forgery(:name).company_name }
  end
end
