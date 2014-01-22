class Competition < ActiveRecord::Base
  belongs_to :team
  has_many :events, dependent: :destroy
  has_many :couples, -> { distinct }, through: :events
  has_many :levels, -> { distinct }, through: :events
  has_many :adjudicators, dependent: :destroy
end
