class Competition < ActiveRecord::Base
  belongs_to :team
  has_many :events, -> { order(number: :asc) }, dependent: :destroy
  has_many :couples, -> { distinct }, through: :events
  has_many :levels, -> { distinct }, through: :events
  has_many :adjudicators, -> { order(shorthand: :asc) }, dependent: :destroy
end
