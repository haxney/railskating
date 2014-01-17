# This is a pretty direct port from the Scheme-based scrutineering software used
# at Brown Comp 2009.
module Scrutineering
  class Finalist
    # The `id` column of the {Couple} which this {Finalist} represents.
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

  # A finalist in a linked dance. The fields inherited from {Finalist} treat
  # individual dances as marks.
  class LinkedFinalist < Finalist
    # An Array, ordered by dance, of the place the finalist received for that
    # dance.
    attr_accessor :places

    # The sum of the finalist's places.
    attr_accessor :sum

    # Another {Finalist} structure treating the marks from all dances as a
    # single dance.
    attr_accessor :as_single_dance

    # Indicates which rule was used to break the tie for this {LinkedFinalist}.
    # It is either `10` or `11`.
    attr_accessor :rule

    # Create a new {LinkedFinalist} using the given arguments
    def initialize(id, cum_marks, cum_sums, places, sum, as_single)
      super(id, cum_marks, cum_sums)
      @places = places
      @sum = sum
      @as_single_dance = as_single
    end
  end

  def self.cum_marks(finalist, place)
    finalist.cumulative_marks[place - 1]
  end

  def self.cum_sum(finalist, place)
    finalist.cumulative_sums[place - 1]
  end

  # Finds `id` in `single_result`.
  #
  # @param [Integer] id {Couple} id to find.
  # @param [Array<Array<Integer, Finalist>>] single_result array of `[place,
  #   finalist]` arrays, as returned from {::compute_all_places}.
  # @return [Array<Integer, Finalist>] the placement of the {Finalist} with the
  #   given `id` as an array `[place, finalist]`.
  def self.find_in_single_dance(id, single_result)
    single_result.find { |pl_f| id == pl_f.second.id }
  end

  def self.place_of(id, single_result)
    find_in_single_dance(id, single_result).first
  end

  # Sum the elements at each position from each array. The idea is to turn
  #
  #     [[1, 2, 3], [4, 5, 6]]
  #
  # Into
  #
  #     [5, 7, 9]
  #
  # Assumes that each of `vecs` are the same length.
  def self.vector_sum(vecs)
    Array.new(vecs.first.length) {0}.zip(*vecs).map { |i| i.reduce(&:+) }
  end

  # Combines all of the single-dance results into {LinkedFinalist} structures.
  #
  # @param [Array<Array<Array<Integer, Finalist>>>] single_results array of
  # results returned by {::place_one_dance}
  # @return [Array<LinkedFinalist>] array of {LinkedFinalist}s.
  def self.single_results_to_linked_finalists(single_results)
    num_finalists = single_results.first.length
    finalists = single_results.first.map(&:second)
    finalists.map do |f|
      id = f.id
      places = single_results.map { |sr| place_of(id, sr) }
      cum_marks = (1..num_finalists).map { |i| places.select { |p| p <= i }.count }
      cum_sums  = (1..num_finalists).map { |i| places.select { |p| p <= i }
          .reduce(0) { |acc, m| acc + m } }
      fs_single_dances = single_results.map { |sr| find_in_single_dance(id, sr).second }

      cum_marks_single = vector_sum(fs_single_dances.map(&:cumulative_marks))
      cum_sums_single = vector_sum(fs_single_dances.map(&:cumulative_sums))

      LinkedFinalist.new(id, cum_marks, cum_sums, places, places.reduce(&:+),
                         Finalist.new(id, cum_marks_single, cum_sums_single))
    end
  end

  # Finds the `place_to_assign`-th place competitor from `finalists` for a
  # single dance event, using rules 5 through 8 from the skating system.
  #
  # @param [Array<Finalist>] finalists the {Finalist}s to place.
  # @param [Integer] place_to_assign the place to assign.
  #
  # @return [Array<Array<Integer, Finalist>>] Array of `[placement, finalist]` arrays.
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
          lowest_sum = sorted_by_sum.select do |f|
            cum_sum(f, place) == cum_sum(sorted_by_sum.first, place)
          end
          case
          when lowest_sum.count == 1
            [[place_to_assign, lowest_sum.first]] # Unique lowest sum
          when place < max_place
            inner.call(place + 1, lowest_sum) # still tied: advance to next column
          else # Genuine tie
            score = place_to_assign + (lowest_sum.length - 1) / 2
            lowest_sum.map { |c| [score, c] }
          end
        end
      end
    end

    inner.call(1, finalists)
  end

  # Determines the `place`th {LinkedFinalist}, starting with rule 9 of the
  # skating system. If this rule produces a tie, it calls {::rule_10} to settle
  # it.
  #
  # @param [Array<LinkedFinalist>] linked_finalists {LinkedFinalist}s to place.
  # @param [Integer] place the place to assign.
  # @return [Array<Array<Integer, LinkedFinalist>>] array of `[place, linked_finalist]` arrays.
  def self.rule_9(linked_finalists, place)
    sorted = linked_finalists.sort_by { |lf| lf.sum }
    highest = sorted.first.sum
    contenders = sorted.select { |lf| lf.sum == highest }
    if contenders.length == 1
      [[place, contenders.first]] # Rule 9
    else
      rule_10(contenders, place)
    end
  end

  # Determines the `place`th {LinkedFinalist}, starting with rule 10 of the
  # skating system. If this rule produces a tie, it calls {::rule_11} to break
  # it.
  #
  # @param [Array<LinkedFinalist>] contenders the {LinkedFinalist}s which have
  #   the same sum of sub-dance placements.
  # @param [Integer] place the place to assign.
  # @return [Array<Array<Integer, LinkedFinalist>>] array of `[place,
  #   linked_finalist]` arrays.
  def self.rule_10(contenders, place)
    contenders.each { |lf| lf.rule ||= 10 }
    by_count = contenders.sort_by { |lf| cum_marks(lf, place) }.reverse
    by_count_max = cum_marks(by_count.first, place)
    highest_count = by_count.select { |lf| cum_marks(lf, place) == by_count_max }
    if highest_count.length == 1
      [[place, highest_count.first]] # Rule 10, part 1
    else
      by_sum = highest_count.sort_by { |lf| cum_sum(lf, place) }
      by_sum_max = cum_sum(by_sum.first, place)
      lowest_sum = by_sum.select { |lf| cum_sum(lf, place) == by_sum_max }
      if lowest_sum.length == 1
        [[place, lowest_sum.first]] # Rule 10, part 2
      else
        rule_11(lowest_sum, place)
      end
    end
  end

  # Determines the `place`th linked finalist, using rule 11 (the final
  # tie-breaker) of the skating system.
  #
  # @param [Array<LinkedFinalist>] lowest_sum the {LinkedFinalist}s which have
  #   the same sum-of-placements.
  # @param [Integer] place the place to assign.
  # @return [Array<Array<Integer, LinkedFinalist>>] array of `[place,
  #   linked_finalist]` arrays.
  def self.rule_11(lowest_sum, place)
    lowest_sum.each { |lf| lf.rule = 11 }
    results = rules_5_to_8(lowest_sum.map(&:as_single_dance), place)
    placed = results.map(&:second).map do |lf|
      find_in_single_dance(lf.id, lowest_sum.map { |ls| [place, ls] })
    end
    # Remove finalists who were placed by {#rules_5_to_8}
    unplaced = lowest_sum.dup
    placed.each { |p| unplaced.reject! { |up| up == p.second } }
    if unplaced.empty?
      placed.each { |p| p.second.rule = 10 } if placed.length > 1
      placed
    else
      # Use rule 10 to place the remaining couples
      rule_10(unplaced, place + placed.length) + placed
    end
  end

  # Repeatedly applies `compute_next` to the array of `finalists`.
  #
  # @param finalists [Array<Finalist>] Array of {Finalist}s to compute.
  # @param compute_next [Function] a function which takes a list of {Finalist}
  #   objects and the numerical rank to place.
  # @return [Array<Array<Integer, Finalist>>] array of `[place, finalist]`
  #   arrays, sorted by increasing place.
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

  # Place a single dance.
  #
  # @param [Array<Finalist>] finalists array of {Finalist} structures.
  #
  # @return [Array<Array<Integer, Finalist>>] array of `[place,
  # finalist]` arrays, sorted by increasing place.
  def self.place_one_dance(finalists)
    compute_all_places(finalists,
                       Scrutineering.method(:rules_5_to_8))
  end
end
