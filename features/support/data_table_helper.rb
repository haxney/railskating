# Finds or creates a couple numbered `num` associated with `round`.
#
# Note that this cannot use {Couple::find_or_create_by} since it must be able to
# add existing couples to `round`. The block accepted by
# {Couple::find_or_create_by} is only executed when the {Couple} is
# newly-created.
def find_or_create_couple(num, round)
  if c = Couple.where(number: num, event: round.event).take
    c
  else
    c = FactoryGirl.create(:couple, number: num, event: round.event)
    round.couples << c
    c
  end
end

# Finds or creates a factory {SubEvent} given a short name. Also creates a
# {SubRound} off of the {Round} given.
#
# @param [String] header a single letter indicating the dance.
# @param [Round] round parent {Round} object.
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

# Converts an array of {Placement} models to a 2D string array to compare to a
# table from a Cucumber step.
#
#
# @param [Array<Placement>] placements array of placements to convert.
# @return [Array<Array<String>>] 2D array of strings representing a table.
def placements_to_table(placements)
  sorted = placements.sort_by { |p| p.couple.number }
  sorted.map do |p|
    hash = { 'couple' => p.couple.number, 'rank' => rank_to_s(p.rank) }
    if Placement === p
      hash['rule'] = ((p.rule) ? "R#{p.rule}" : "")
    end
    hash
  end
end

# Converts a `rank` to a string, including the decimal point only if `rank` is
# not an integer.
#
# @param [Rational] rank The rank of a couple.
#
# @return [String] The rank as a string. Includes a decimal only if `rank` is
#   not an integer.
def rank_to_s(rank)
  if rank.denominator == 1
    rank.to_i.to_s
  else
    rank.to_f.to_s
  end
end
