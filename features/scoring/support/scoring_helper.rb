# Helper functions for testing scoring steps.

def find_or_create_adjudicator(header, competition)
  Adjudicator.where(shorthand: header, competition: competition).take or
    FactoryGirl.create(:adjudicator, shorthand: header, competition: competition)
end

def find_or_create_couple(num, round)
  c = Couple.where(number: num, event: round.event).take ||
    FactoryGirl.create(:couple, number: num, event: round.event)
  round.couples << c
  c
end

# Finds or creates a factory {SubEvent} given a short name. Also creates a
# {SubRound} off of the {Round} given.
#
# @param [String] header a single letter indicating the dance.
# @param [Round] event parent {Round} object.
# @return [SubEvent] a {SubEvent}
def find_or_create_sub_event(header, round)
  dance = case header
          when 'W' then Constants::Dances::INTERNATIONAL_WALTZ
          when 'T' then Constants::Dances::INTERNATIONAL_TANGO
          when 'F' then Constants::Dances::INTERNATIONAL_FOXTROT
          when 'V' then Constants::Dances::INTERNATIONAL_VIENNESE_WALTZ
          when 'Q' then Constants::Dances::INTERNATIONAL_QUICKSTEP
          else raise ArgumentError, "Expected dance to be one of 'W', 'T', 'F', 'V', 'Q', got #{header}"
          end
  se = SubEvent.where(event: round.event, dance: dance).take ||
    FactoryGirl.create(:sub_event, event: round.event, dance: dance)
  SubRound.where(round: round, sub_event: se).take ||
    FactoryGirl.create(:sub_round, round: round, sub_event: se)
  se
end

def expect_model_class(model, klass)
  raise UnexpectedModelClass, "Expected a '#{klass}' object, but got '#{model.class}'" unless model.class == klass
end

# Converts an array of {Placement} models to a 2D string array compatible with
# {Cucumber::Ast::Table#diff!}.
#
# @param [Array<Placement>] placements array of placements to convert.
# @return [Array<Array<String>>] 2D array of strings representing a table.
def placements_to_table(placements)
  sorted = placements.sort_by { |p| p.couple.number }
  [['couple', 'rank']] + sorted.map do |p|
    [p.couple.number.to_s,
     p.rank.to_s + ((p.rule) ? " R#{p.rule}" : "")]
  end
end
