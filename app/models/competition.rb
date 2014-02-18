class Competition < ActiveRecord::Base
  extend Enumerize

  belongs_to :team
  has_many :events, -> { order(number: :asc) }, dependent: :destroy
  has_many :couples, -> { distinct }, through: :events
  has_many :levels, -> { distinct }, through: :events
  has_many :adjudicators, -> { order(shorthand: :asc) }, dependent: :destroy

  # @!attribute status
  #   @return [Symbol] the status of the {Competition}.
  #
  #   The `status` is one of the following:
  #
  #   - `creating`: The competition administrator is creating the competition.
  #     The competition will not be visible to anyone but the comp admins.
  #
  #   - `registering`: The competition is open for registration. Anyone can
  #     register for the comp and it shows up in lists.
  #
  #   - `closed_registration`: Registration for the competition is closed.
  #
  #   - `in_progress`: The competition is in progress.
  #
  #   - `finished`: The competition is complete and the results can be shown.
  enumerize :status, in: %i(creating
                            registering
                            closed_registration
                            in_progress
                            finished),
                     default: :creating
end
