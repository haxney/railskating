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
end
