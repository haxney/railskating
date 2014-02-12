require 'exceptions'

class SubEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :dance
  has_many :sub_rounds, dependent: :destroy

  # @!attribute sub_placements
  #   @return [Array<SubPlacement>] The {SubPlacement}s for this {SubEvent}.
  has_many :sub_placements, -> { order(:rank) }, dependent: :destroy
  has_many :rounds, -> { distinct.order(:number) }, through: :sub_rounds
  has_one :section, through: :dance

  def final_sub_round
    @final_sub_round ||= self.sub_rounds.joins(:round)
      .where(rounds: { final: true }).take
  end

  # Whether this {SubEvent} has a final {SubRound} and has had its scores
  # tallied.
  #
  # @return [Boolean] true if this {SubEvent} has final and has placed the
  #   couples.
  def resolved?
    self.final_sub_round && self.sub_placements.size > 0
  end

  # Computes the placements of the couples and stores the results in the
  # {#sub_placements} association.
  #
  # @return [Array<SubPlacement>] the computed {Placement} objects.
  def compute_sub_placements
    raise RoundFinalnessError, "No final sub round for sub_event" unless final_sub_round
    return self.sub_placements if resolved?

    finalists = final_sub_round.couples.map do |c|
      c.to_single_finalist(final_sub_round)
    end

    places = Scrutineering.place_one_dance(finalists)
    adsf = places.map do |elt|
      # Potential issues with floating point here, but without converting, there
      # was an argument error.
      self.sub_placements.create(rank: elt.first.to_f, couple_id: elt.second.id)
    end

    adsf
  end

  # Build an array of the form returned by {#Scrutineering::compute_all_places}.
  #
  # @return [Array<Array<Integer, Finalist>>] array of `[place, finalist]`
  #   arrays, sorted by increasing place.
  def to_single_results
    raise RoundFinalnessError, "No final sub round for sub_event" unless final_sub_round

    compute_placements unless resolved?

    self.sub_placements.map do |sp|
      [sp.rank, sp.couple.to_single_finalist(final_sub_round)]
    end
  end
end
