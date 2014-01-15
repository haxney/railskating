class SubRound < ActiveRecord::Base
  belongs_to :round
  belongs_to :sub_event
  has_many :marks
  has_many :couple_round_tallies
  has_many :couples, through: :round
end
