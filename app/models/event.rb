class Event < ActiveRecord::Base
  belongs_to :competition
  belongs_to :level
  has_many :couples
  has_many :rounds
  has_many :sub_events
  has_many :dances, through: :sub_events
  has_many :sections, through: :dances
end
