class SubPlacement < ActiveRecord::Base
  belongs_to :couple
  belongs_to :sub_event

  # Converts a `rank` to a string, including the decimal point only if `rank`
  # is not an integer.
  #
  # @return [String] The rank as a string. Includes a decimal only if `rank` is
  #   not an integer.
  def rank_to_s
    if rank.frac == 0
      rank.to_i.to_s
    else
      rank.to_f.to_s
    end
  end
end
