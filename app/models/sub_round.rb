class SubRound < ActiveRecord::Base
  belongs_to :round
  belongs_to :sub_event
  has_many :marks, dependent: :destroy
  has_many :couples, -> { distinct.order('couples.number ASC') }, through: :round

  has_one :dance, through: :sub_event
end
