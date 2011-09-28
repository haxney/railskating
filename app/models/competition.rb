class Competition < ActiveRecord::Base
  belongs_to :team
  has_many :events
  has_many :couples, through: :events
  has_many :levels, through: :events
  has_many :adjudicators
end
