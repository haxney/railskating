require 'spec_helper'

describe Round do

  # example markings taken from
  # [here](http://www.worldsalsafederation.com/Skating%20System.html)
  describe "#recall" do
    let(:competition) { build(:competition) }
    let(:event) { build(:event, competition: competition) }
    let(:sub_event) { build(:sub_event, event: event) }
    let(:round) { build(:round, event: event, requested: 6) }
    let(:sub_round) { build(:sub_round, round: round, sub_event: sub_event) }
    let(:couples) { build_list(:couple, 10, event: event) }
    let(:adjudicators) { build_list(:adjudicator, 7, competition: competition) }

    # Modified slightly from "Rule 1" section to avoid a tie. Judge "F" marks
    # couple 16 rather than 10, preventing a tie.
    #
    # Source looks like this (post modification):
    #
    # | No | A | B | C | D | E | F | G | Total |
    # |----+---+---+---+---+---+---+---+-------|
    # | 10 |   | X | X | X |   |   |   |     3 |
    # | 11 | X |   | X | X | X | X |   |     6 |
    # | 12 | X | X |   | X |   |   | X |     4 |
    # | 13 |   |   | X |   |   | X | X |     3 |
    # | 14 | X | X |   |   | X | X |   |     4 |
    # | 15 |   | X | X | X | X | X | X |     6 |
    # | 16 |   |   |   |   |   | X |   |     1 |
    # | 17 | X | X | X | X | X |   | X |     6 |
    # | 18 | X | X | X | X | X | X | X |     7 |
    # | 19 | X |   |   |   | X |   |   |     2 |
    context "without a tie" do
      before do
        build(:mark, adjudicator: adjudicators[0], sub_round: sub_round, couple: couples[0])
      end
    end

    # Original table from the Rule 1 section. Couples 11, 15, 17, and 18 have
    # the highest marks and make it to the next round. Couples 10, 12, and 14
    # have 4 marks, so either 4 or 7 couples can be recalled. The chairman
    # decides which option to take.
    #
    # | No | A | B | C | D | E | F | G | Total |
    # |----+---+---+---+---+---+---+---+-------|
    # | 10 |   | X | X | X |   | X |   |     4 |
    # | 11 | X |   | X | X | X | X |   |     6 |
    # | 12 | X | X |   | X |   |   | X |     4 |
    # | 13 |   |   | X |   |   | X | X |     3 |
    # | 14 | X | X |   |   | X | X |   |     4 |
    # | 15 |   | X | X | X | X | X | X |     6 |
    # | 16 |   |   |   |   |   |   |   |     0 |
    # | 17 | X | X | X | X | X |   | X |     6 |
    # | 18 | X | X | X | X | X | X | X |     7 |
    # | 19 | X |   |   |   | X |   |   |     2 |
    context "with a tie" do
    end
  end
end
