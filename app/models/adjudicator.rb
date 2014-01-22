class Adjudicator < ActiveRecord::Base
  has_many :marks, dependent: :restrict_with_exception
  belongs_to :user
  belongs_to :competition

  # The rounds which this judge scored.
  has_and_belongs_to_many :rounds, -> { uniq }
end
