class Round < ActiveRecord::Base
  belongs_to :event
  has_many :sub_rounds
end
