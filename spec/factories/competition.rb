FactoryGirl.define do
  factory :competition do
    ignore { name "Brown Competition" }
    start_date Date.new(2013,11,17)
    end_date Date.new(2013,11,17)
    team
    initialize_with { Competition.find_or_create_by(name: name) }
  end
end
