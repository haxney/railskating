class Mark < ActiveRecord::Base
  belongs_to :adjudicator
  belongs_to :sub_round
  belongs_to :couple
end
