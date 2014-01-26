module AdjudicatorsHelper

  # Builds an array of classes to apply to table headers for this {Adjudicator}.
  def adjudicator_header_classes(adjudicator, sub_round)
    ['adjudicator_col',
     "adjudicator_#{adjudicator.shorthand}_col",
     dance_to_class_name(sub_round.sub_event.dance)]
  end
end
