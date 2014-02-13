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

  # Return a list of the classes to use for a final round placement cell. If
  # `dance` is not `nil`, create sub_placement classes.
  def placement_cell_classes(dance=nil)
    prefix = dance ? 'sub_' : ''
    cls = ["#{prefix}placement_col",
           "#{prefix}placement_cell",
           'data_cell']
    if dance
      cls << dance_to_class_name(dance)
    else
      cls
    end
  end

  # Formats a cumulative cell for a given {Couple}, {SubRound}, and number of
  # marks.
  def format_cumulative_cell(couple, sub_round, num)
    finalist = couple.to_single_finalist(sub_round)
    cum_marks = finalist.cumulative_marks[num - 1]
    (cum_marks == 0) ? "–" : cum_marks
  end

  # Formats the "Total" cell for a couple. This is the sum of the placements
  # received by the couple
  def format_total_placements_cell(couple)
    couple.sub_placements.map(&:rank).reduce(&:+)
  end

  def rule_cell_classes(placement)
    cls = ['rule_col']
    rule = placement.rule
    case rule
    when 10, 11 then cls << "rule_col_#{rule}"
    else cls
    end
  end

  # Format the "Rule" cell for a couple.
  #
  # @param [Integer] rule The placement to format.
  def format_rule_cell(rule)
    case rule
    when 10, 11 then "R#{rule}"
    else ''
    end
  end
end
