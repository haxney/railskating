require 'scrutineering'

class Couple < ActiveRecord::Base
  belongs_to :lead, class_name: 'User', inverse_of: :lead_couples
  belongs_to :follow, class_name: 'User', inverse_of: :follow_couples
  belongs_to :event, inverse_of: :couples
  has_one :competition, through: :event
  has_many :marks, dependent: :destroy
  has_many :couple_round_tallies
  has_and_belongs_to_many :rounds
  before_destroy { rounds.clear }
  has_many :placements, dependent: :restrict_with_exception
  has_many :sub_placements, dependent: :restrict_with_exception

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

  # Determines whether this {Couple} was recalled from the given {Round}.
  #
  # @param [Round] round The {Round} to examine.
  #
  # @return [Boolean] `true` if this {Couple} was recalled from `round`.
  def recalled_from?(round)
    recalled = round.recalled_couples
    recalled.respond_to?(:include?) ? recalled.include?(self) : false
  end

  # Returns the {Placement} of this {Couple} in `round`. If this {Couple} was
  # not in `round`, raises an exception.
  #
  # @param [Round, SubRound] round The {Round} or {SubRound} to check.
  #
  # @return [Placement, SubPlacement] The {Placement} or {SubPlacement} of the
  #   couple.
  def placement_in(round)
    res = case round
          when Round
            Placement.find_by(couple: self, event: round.event)
          when SubRound
            SubPlacement.find_by(couple: self, sub_event: round.sub_event)
          else
            raise "Expected a Round or SubRound, got #{round.class.name}"
          end

    if res
      res
    else
      raise "No placement found for Couple #{self.id} in #{round.class.name} #{round.id}"
    end
  end
end
