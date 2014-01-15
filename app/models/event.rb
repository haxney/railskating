require 'scrutineering'

class Event < ActiveRecord::Base
  belongs_to :competition
  belongs_to :level
  has_many :couples
  has_many :rounds
  has_many :sub_events
  has_many :dances, through: :sub_events
  has_many :sections, through: :dances
  has_many :placements

  def final_round
    @final_round ||= self.rounds.where(final: true).first
  end

  def resolved?
    (self.placements) ? true : false
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

    if single_dance?
      compute_next = Scrutineering.method(:rules_5_to_8)
      finalists = couples.map do |c|
        c.to_single_finalist(final_round.sub_rounds.take!)
      end
    else
      compute_next = Scrutineering.method(:rule_9)
      single_results = final_round.sub_rounds.map do |sr|
        sub_finalists = couples.map do |c|
          c.to_single_finalist(sr)
        end
        Scrutineering.compute_all_places(sub_finalists, Scrutineering.method(:rules_5_to_8))
      end

      finalists = Scrutineering.single_results_to_linked_finalists(single_results)
    end

    placements = Scrutineering.compute_all_places(finalists, compute_next)

    placements.map do |elt|
      p = self.placements.build(rank: elt.first, couple_id: elt.second.id)
      p.rule = elt.second.rule if elt.second.respond_to? :rule
      p.save
    end
  end
end
