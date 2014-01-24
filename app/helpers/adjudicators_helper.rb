module AdjudicatorsHelper

  # Builds an array of classes to apply to table headers for this {Adjudicator}.
  def adjudicator_header_classes(adjudicator)
    ['adjudicator_header', "adjudicator_header_#{adjudicator.shorthand}"]
  end
end
