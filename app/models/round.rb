class Round < ActiveRecord::Base
  belongs_to :event
  has_many :sub_rounds

  # Couples entering the round
  has_and_belongs_to_many :couples

  has_many :couple_tallies, class_name: 'CoupleRoundTally'

  has_many :prelim_results, class_name: 'CoupleRoundTally', finder_sql:
    proc { <<-SQL
          SELECT t1.num_marks,
                 (
                   SELECT count(t2.couple_id)
                   FROM couple_round_tallies AS t2
                   WHERE t2.num_marks >= t1.num_marks AND
                         t1.round_id = #{self.id}
                 ) AS num_couples
            FROM couple_round_tallies AS t1
            WHERE t1.round_id = #{self.id}
            GROUP BY t1.num_marks
            ORDER BY t1.num_marks DESC;
      SQL
  }

  # Returns the couples to be recalled to the next round, if possible.
  #
  # If `self.requested` couples cannot be recalled, returns `false`. Is only
  # meaningful for preliminary rounds
  def recalled_couples
    raise RoundFinalnessError, "cannot recall couples from final round" if self.final?

    # Since `prelim_results` is cumulative, there is guaranteed to be at most
    # one matching element.
    res = self.prelim_results.select { |p| p.num_couples == self.requested }
    return false if res.empty?

    num_marks = res.first.num_marks
    c_ids = self.couple_tallies
      .where(['num_marks >= ?', num_marks])
      .map { |ct| ct.couple_id }
    Couple.find(c_ids)
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
end
