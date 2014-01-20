class SubRound < ActiveRecord::Base
  belongs_to :round
  belongs_to :sub_event
  has_many :marks
  has_many :couples, -> { distinct }, through: :round

  has_one :dance, through: :sub_event
end
