module RoundsHelper

  # Returns the class to use for the results table.
  def round_table_classes(round)
    ["results_round",
     "results_round_#{round.final? ? 'final' : 'prelim'}"]
  end

  # Returns the id to use for the results table.
  def round_table_id(round)
    "results_round_#{round.number}"
  end

  # Returns the `colspan` to use for the round header. If it is a final round,
  # then an extra column is added for the overall placement.
  def round_header_colspan(round)
    round.adjudicators.length
  end
end
