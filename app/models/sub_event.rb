class SubEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :dance
  has_many :sub_rounds
  has_many :sub_placements
  has_many :rounds, through: :sub_rounds
  has_one :section, through: :dance
end
