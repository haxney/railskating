class SubRound < ActiveRecord::Base
  belongs_to :round
  belongs_to :sub_event
end