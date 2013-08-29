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

end
