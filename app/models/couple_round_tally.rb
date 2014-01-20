class CoupleRoundTally < ActiveRecord::Base
  belongs_to :round
  belongs_to :couple
end
