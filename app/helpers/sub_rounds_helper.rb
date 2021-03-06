module SubRoundsHelper
  # Returns the class to use for the results table.
  def sub_round_table_classes(sub_round)
    ['results_sub_round_final',
     'results_round',
     dance_to_class_name(sub_round.dance)]
  end

  # Returns the id to use for the results table.
  def sub_round_table_id(sub_round)
    round = sub_round.round
    se = sub_round.sub_event
    "results_sub_round_#{round.number}_#{se.weight}"
  end

  # Formats a number as a cumulative placement.
  #
  # @example
  #   cumulative_placement_header(1) #=> "1"
  #   cumulative_placement_header(2) #=> "1–1"
  #
  # @param [Integer] num The number for the header.
  def cumulative_placement_header(num)
    (num == 1) ? "1" : "1–#{num}"
  end
end
