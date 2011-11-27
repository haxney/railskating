FactoryGirl.define do
  factory :competition do
    name "Brown Competition"
    start_date 3.days.ago.to_date
    end_date 1.day.ago.to_date
    team
  end
end
