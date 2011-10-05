FactoryGirl.define do
  factory :level do
    name 'Gold'
    weight 300
  end

  factory :random_level, parent: :level do
    name { Forgery(:ballroom).level }
    weight { Forgery::Extend(100..800).random }
  end
end
