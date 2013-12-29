# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :placement do
    couple
    event
    rank 1
    rule 5
  end
end
