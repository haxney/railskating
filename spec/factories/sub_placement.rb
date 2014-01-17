# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sub_placement do
    couple
    sub_event
    rank 1
  end
end
