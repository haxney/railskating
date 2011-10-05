FactoryGirl.define do
  factory :competition do
    name "Brown Competition"
    start_date 3.days.ago.to_date
    end_date 1.day.ago.to_date
    team
  end

  factory :random_competition, parent: :competition do
    name { Forgery(:name).company_name }
    start_date { Forgery(:date).date }
    end_date { start_date + 1.day }
  end
end
