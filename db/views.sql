DROP VIEW IF EXISTS couple_round_tallies;

CREATE VIEW couple_round_tallies AS
  SELECT couples.id AS couple_id,
         count(marks.id) AS num_marks,
         rounds.id AS round_id
    FROM rounds
    INNER JOIN sub_rounds ON sub_rounds.round_id = rounds.id
    INNER JOIN marks ON marks.sub_round_id = sub_rounds.id
    INNER JOIN couples ON couples.id = marks.couple_id
    GROUP BY couples.id, rounds.id;
