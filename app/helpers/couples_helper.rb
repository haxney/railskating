module CouplesHelper

  # Formats a single cell for the {Couple}, {SubRound}, and {Adjudicator}.
  #
  # @param [Couple] couple The couple. Its {Couple#marks marks} association
  #   should contain only {Mark}s for `sub_round`.
  # @param [SubRound] sub_round The sub round.
  # @param [Adjudicator] adjudicator The adjudicator.
  #
  # @return [String] A FontAwesome check mark if `sub_round` is part of a
  #   preliminary {Round} and the `adjudicator` marked the `couple`, an integer
  #   (as a string) if the {Round} was final, or and empty string, if the
  #   adjudicator did not mark the couple.
  def format_cell(couple, sub_round, adjudicator)
    mark = Mark.find_by(adjudicator: adjudicator,
                        sub_round_id: sub_round.id,
                        couple: couple)
    if mark
      text = content_tag(:span, 'Mark', class: 'hidden')
      (mark.placement == 0) ? fa_icon('check', text: text) : mark.placement.to_s
    else
      content_tag(:span, 'No mark', class: 'hidden')
    end
  end

  # Compute the classes to use for a mark cell.
  #
  # @return [Array<String>] Array of strings in which the first element is the encoded
  def mark_cell_classes(sub_round, adjudicator)
    ['mark_cell',
     'data_cell',
     dance_to_class_name(sub_round.sub_event.dance),
     'adjudicator_col',
     "adjudicator_#{adjudicator.shorthand}_col"]
  end

  # Compute the classes to use for a result cell.
  def result_cell_classes(round)
    ['result_cell',
     'data_cell',
     'recalled_col']
  end

  # Return the list of classes to use for a cumulative results cell.
  def cumulative_cell_classes(num)
    ['data_cell',
     'cumulative_cell',
     "cumulative_cell_#{num}"]
  end

  # Formats a cumulative cell for a given {Couple}, {SubRound}, and number of
  # marks.
  def format_cumulative_cell(couple, sub_round, num)
    finalist = couple.to_single_finalist(sub_round)
    cum_marks = finalist.cumulative_marks[num - 1]
    (cum_marks == 0) ? "–" : cum_marks
  end
end
