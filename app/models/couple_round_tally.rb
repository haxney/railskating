class CoupleRoundTally < ActiveRecord::Base
  belongs_to :sub_round
  belongs_to :round
  belongs_to :couple
end
