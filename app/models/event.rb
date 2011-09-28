class Event < ActiveRecord::Base
  belongs_to :competition
  belongs_to :level
  has_many :couples
end
