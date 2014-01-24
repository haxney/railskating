module RoundsHelper

  # Returns the class to use for the results table.
  def round_table_class(round)
    ["results_round_#{round.final? ? 'final' : 'prelim'}"]
  end
end
