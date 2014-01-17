class Competition < ActiveRecord::Base
  belongs_to :team
  has_many :events
  has_many :couples, -> { distinct }, through: :events
  has_many :levels, -> { distinct }, through: :events
  has_many :adjudicators
end
