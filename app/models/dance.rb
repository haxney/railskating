class Dance < ActiveRecord::Base
  belongs_to :section
  has_many :sub_events
end
