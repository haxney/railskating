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

  # Computes the placements of the couples and stores the results in the
  # `placements` association.
  def compute_placements
    raise RoundFinalnessError, "No final round for event" unless self.final_round

    # Currently, only does single finals
    finalists = couples.map do |c|
      c.to_single_finalist(final_round.sub_rounds.take!)
    end

    placements = Scrutineering.compute_all_places(finalists,
                                                  Scrutineering.method(:rules_5_to_8))

    placements.map do |elt|
      self.placements.create(rank: elt[0], couple_id: elt[1].id)
    end
  end
end
