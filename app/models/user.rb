class User < ActiveRecord::Base
  belongs_to :team
  has_many :lead_couples, class_name: 'Couple', foreign_key: :lead_id
  has_many :follow_couples, class_name: 'Couple', foreign_key: :follow_id
end
