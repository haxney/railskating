class Round < ActiveRecord::Base
  belongs_to :event
  has_many :sub_rounds
  has_and_belongs_to_many :couples
end
