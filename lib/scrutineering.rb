# This is a pretty direct port from the Scheme-based scrutineering software used
# at Brown Comp 2009.
module Scrutineering
  class Finalist
    attr_accessor :id

    # Array where the value at position i (starting from 1) is the number of
    # judges who marked this couple ith or better
    attr_accessor :cumulative_marks
    # a list where the value at position i (starting from 1) is the sum of the
    # couple's places at ith or better
    attr_accessor :cumulative_sums

    def initialize(id, cum_marks, cum_sums)
      @id = id
      @cumulative_marks = cum_marks
      @cumulative_sums = cum_sums
    end
  end

  class LinkedFinalist < Finalist
    attr_accessor :places, :sum, :as_single_dance, :rule
  end

  def self.cum_marks(finalist, place)
    finalist.cumulative_marks[place - 1]
  end

  def self.cum_sum(finalist, place)
    finalist.cumulative_sums[place - 1]
  end

  # Finds the `place_to_assign`-th place competitor from `finalists` for a
  # single dance event, using rules 5 through 8 from the skating system.
  def self.rules_5_to_8(finalists, place_to_assign)
    majority = (finalists.first.cumulative_marks.last / 2).next
    max_place = finalists.first.cumulative_marks.count

    inner = lambda do |place, contenders|
      contenders = contenders.select { |f| cum_marks(f, place) >= majority }
      contenders = contenders.sort_by { |f| cum_marks(f, place) }
      contenders.reverse!

      case
      when contenders.empty?
        inner.call(place + 1, finalists) # Rule 8
      when contenders.count == 1
        [[place_to_assign, contenders.first]] # Rule 5
      else # Break ties
        # Rule 6
        highest_marks = contenders.select { |c|
          cum_marks(c, place) == cum_marks(contenders.first, place) }
        if highest_marks.count == 1
          [[place_to_assign, highest_marks.first]] # Unique highest majority
        else
          # Rule 7
          sorted_by_sum = highest_marks.sort_by { |f| cum_sum(f, place) }
          lowest_sum = sorted_by_sum.select { |f|
            cum_sum(f, place) == cum_sum(sorted_by_sum.first, place) }
          case
          when lowest_sum.count == 1
            [[place_to_assign, lowest_sum]] # Unique lowest sum
          when place < max_place
            inner.call(place + 1, lowest_sum) # still tied: advance to next column
          else # Genuine tie
            score = place_to_assign + (lowest_sum - 1) / 2
            lowest_sum.map { |c| [score, c]}
          end
        end
      end
    end

    inner.call(1, finalists)
  end

  # Repeatedly applies `compute_next` to the list of `finalists`.
  #
  # `compute_next` is a function which takes a list of `Finalist` objects and
  # the numerical rank to place.
  #
  # Returns a list of lists `(place finalist)`, sorted by increasing place.
  def self.compute_all_places(finalists, compute_next)
     inner = lambda do |placed, unplaced|
      if unplaced.empty?
        placed.reverse!
      else
        newly_placed = compute_next.call(unplaced, placed.count + 1)
        newly_placed.each { |np| unplaced.reject! { |up| up == np[1] } }
        inner.call(newly_placed + placed,
                   unplaced)
      end
    end

    inner.call([], finalists)
  end
end
