FactoryGirl.define do
  factory :user do
    first_name { Forgery(:name).first_name }
    last_name { Forgery(:name).last_name }
  end

  factory :random_user, parent: :user do
    first_name { Forgery(:name).first_name }
    last_name { Forgery(:name).last_name }
  end
end
