class Placement < ActiveRecord::Base
  belongs_to :couple
  belongs_to :event

  # Returns a string representation of the rank suitable for display to the
  # user. Present to match the signature of {SubPlacement::rank_to_s}
  def rank_to_s
    rank.to_s
  end
end
