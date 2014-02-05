class Round < ActiveRecord::Base
  belongs_to :event
  has_many :sub_rounds

  # Couples entering the round
  has_and_belongs_to_many :couples, -> { uniq.order(number: :asc) }
  before_destroy { couples.clear }

  # The judges scoring the round.
  has_and_belongs_to_many :adjudicators, -> { uniq.order(shorthand: :asc) }
  before_destroy { adjudicators.clear }

  has_many :couple_tallies, class_name: 'CoupleRoundTally'

  # Calculate the number of couples which would be recalled for a given number
  # of marks.
  #
  # For example, for a single-dance round with 96 couples and 5 judges, the
  # results might be:
  #
  # | num_marks | num_couples |
  # |         5 |          16 |
  # |         4 |          40 |
  # |         3 |          51 |
  # |         2 |          60 |
  # |         1 |          76 |
  #
  # Indicating that with a cutoff of 5 marks, 16 couples would be recalled; with
  # a cutoff of 4 or more marks, 40 couples would be recalled, and so on.
  #
  # @return [Array<CoupleRoundTally>] List of results. They are not really
  #   {CoupleRoundTally} objects, and have only the attributes `num_marks` and
  #   `num_couples`.
  def prelim_results
    t1 = Arel::Table.new(:couple_round_tallies, :as => "t1")
    t2 = Arel::Table.new(:couple_round_tallies, :as => "t2")

    subquery = t2.project(t2[:couple_id].count)
      .where(t2[:num_marks].gteq(t1[:num_marks])
               .and(t2[:round_id].eq(id)))

    query = t1.project(t1[:num_marks], subquery.as('num_couples'))
      .where(t1[:round_id].eq(id))
      .group(t1[:num_marks], t1[:round_id])
      .order(t1[:num_marks].desc)

    CoupleRoundTally.find_by_sql(query)
  end

  # This is a bit aggressive, since it might clear the cache when unrelated
  # attributes are saved, but seeing as how {Round}s are not modified frequently
  # (or at all), this shouldn't matter.
  after_update :clear_recalled

  # Returns the couples to be recalled to the next round, if possible.
  #
  # If `self.requested` couples cannot be recalled, returns `false`. Is only
  # meaningful for preliminary rounds
  def recalled_couples
    raise RoundFinalnessError, "cannot recall couples from final round" if self.final?
    return @recalled if @recalled

    num_marks =
      if self.cutoff
        self.cutoff
      else
        # Since `prelim_results` is cumulative, there is guaranteed to be at
        # most one matching element.
        res = self.prelim_results.select { |p| p.num_couples == self.requested }
        return false if res.empty?

        res.first.num_marks
      end

    c_ids = self.couple_tallies
      .where(['num_marks >= ?', num_marks])
      .map { |ct| ct.couple_id }
    @recalled = Couple.find(c_ids)
  end

  # Determines what number of marks could be used as cutoffs to get closest to
  # the requested number of couples.
  #
  # Returns a two-element array of objects with properties `num_couples` and
  # `num_marks`.
  def possible_cutoffs
    lower = self.prelim_results
      .take_while { |e| e.num_couples < self.requested }[-1]

    upper = self.prelim_results
      .drop_while { |e| e.num_couples < self.requested }[0]

    return [lower, upper]
  end

  # Test whether the requested number of couples can be recalled.
  #
  # Is only meaningful for preliminary rounds.
  def resolved?
    if self.final? or self.recalled_couples
      true
    else
      false
    end
  end

  # Overrides {ActiveModel::Conversion#to_partial_path} to select a different
  # partial for final rounds.
  #
  # @return [String] The path associated with the object, either
  #   `"rounds/round"` for non-final rounds or `"rounds/final_round"` for final
  #   rounds.
  def to_partial_path
    if final?
      'rounds/final_round'
    else
      self.class._to_partial_path
    end
  end

  protected
  # Clear the `@recalled` cache object.
  def clear_recalled
    @recalled = nil
  end
end
