require 'scrutineering'

class Couple < ActiveRecord::Base
  belongs_to :lead, class_name: 'User', inverse_of: :lead_couples
  belongs_to :follow, class_name: 'User', inverse_of: :follow_couples
  belongs_to :event, inverse_of: :couples
  has_one :competition, through: :event
  has_many :marks
  has_many :couple_round_tallies
  has_and_belongs_to_many :rounds
  has_many :placements

  # Convert this couple to a `Finalist` structure for computing placement
  # results.
  def to_single_finalist(sub_round)
    marks = sub_round.marks.where(couple: self)
    num_places = sub_round.round.couples.count
    cum_marks = (1..num_places).map { |i| marks.select { |m| m.placement <= i }.count }
    cum_sums = (1..num_places).map { |i| marks.select { |m| m.placement <= i }
        .reduce(0) { |acc, m| acc + m.placement } }
    Scrutineering::Finalist.new(self.id, cum_marks, cum_sums)
  end
end
