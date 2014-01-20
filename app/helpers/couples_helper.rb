module CouplesHelper

  # Formats a single cell for the {Couple}, {SubRound}, and {Adjudicator}.
  #
  # @param [Couple] couple The couple. Its {Couple#marks marks} association
  #   should contain only {Mark}s for `sub_round`.
  # @param [SubRound] sub_round The sub round.
  # @param [Adjudicator] adjudicator The adjudicator.
  #
  # @return [String] An 'X' if `sub_round` is part of a preliminary {Round} and
  #   the `adjudicator` marked the `couple`, an integer (as a string) if the
  #   {Round} was final, or and empty string, if the adjudicator did not mark
  #   the couple.
  def format_cell(couple, sub_round, adjudicator)
    mark = couple.marks.detect do |m|
      m.sub_round_id == sub_round.id and m.adjudicator_id == adjudicator.id
    end
    if mark
      (mark.placement == 0) ? 'X' : mark.placement.to_s
    else
      ''
    end
  end

  # Compute the classes to use for the cell.
  #
  # @return [Array<String>] Array of strings in which the first element is the encoded
  def cell_classes(sub_round, adjudicator)
    ["sub_round_#{sub_round.dance.name.parameterize.underscore}",
     "adjudicator_#{adjudicator.shorthand}"]
  end
end
