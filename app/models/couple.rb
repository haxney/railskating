class Couple < ActiveRecord::Base
  belongs_to :lead, class_name: 'User', inverse_of: :lead_couples
  belongs_to :follow, class_name: 'User', inverse_of: :follow_couples
  belongs_to :event, inverse_of: :couples
  has_one :competition, through: :event
end
