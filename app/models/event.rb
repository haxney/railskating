require 'scrutineering'
require 'exceptions'

class Event < ActiveRecord::Base
  belongs_to :competition
  belongs_to :level
  has_many :couples, dependent: :destroy
  has_many :rounds, dependent: :destroy
  has_many :sub_events, -> { select('sub_events.*, sub_events.weight AS weight')
      .order('sub_events.weight ASC') }, dependent: :destroy
  has_many :dances, -> { select('dances.*, sub_events.weight AS weight')
      .distinct.reorder('sub_events.weight ASC') }, through: :sub_events
  has_many :sections, -> { distinct }, through: :dances
  has_many :placements, -> { order(:rank) }, dependent: :destroy

  def final_round
    @final_round ||= self.rounds.where(final: true).first
  end

  def resolved?
    self.placements.size > 0
  end

  # Is this {Event} a single-dance event?
  #
  # @return [Boolean] true if this event is a single-dance.
  def single_dance?
    sub_events.size == 1
  end

  # Is this {Event} a multi-dance event?
  #
  # @return [Boolean] true if this event is a multi-dance.
  def multi_dance?
    sub_events.size > 1
  end

  # Computes the placements of the couples and stores the results in the
  # `placements` association.
  def compute_placements
    raise RoundFinalnessError, "No final round for event" unless self.final_round
    return self.placements if resolved?
    sub_events.each { |se| se.compute_sub_placements }

    if single_dance?
      # Copy {SubPlacement}s from {SubEvent}
      sub_events.first.sub_placements.map do |p|
        self.placements.create(rank: p.rank, couple: p.couple)
      end
    else
      # Apply rules 9-11
      single_results = sub_events.map(&:to_single_results)

      finalists = Scrutineering.single_results_to_linked_finalists(single_results)
      places = Scrutineering.compute_all_places(finalists,
                                                Scrutineering.method(:rule_9))
      places.map do |elt|
        self.placements.create(rank: elt.first,
                               couple_id: elt.second.id,
                               rule: elt.second.rule)
      end
    end
  end

  # Returns a representation of the object's key suitable for use in URLs, or
  # `nil` if `persisted?` is `false`. For {Event}s, this is the event number,
  # since the path is built by using the {Competition} id and {Event} number.
  #
  # @return [String] Representation of the {Event}'s key.
  def to_param
    persisted? ? self.number.to_s : nil
  end
end
