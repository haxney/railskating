class Round < ActiveRecord::Base
  belongs_to :event
  has_many :sub_rounds

  # Couples entering the round
  has_and_belongs_to_many :couples

  has_many :couple_tallies, class_name: 'CoupleRoundTally'
end
