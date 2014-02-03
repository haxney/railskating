# For the seed data, the ID of each dance, section, or level will always be
# the same, so define them here.
module Constants

  # Set up the constants for the other modules. Simply add `extend ConstHelper`
  # _after_ defining the required module variables and, for each of the `@@ids`,
  # the following constants will be created:
  #
  #   - `THING_ID`: The numerical ID.
  #   - `THING`: A model, loaded from the database using the specified ID.
  #
  # Additionally, a collection constant will be created which stores an array of
  # all of the models.
  #
  # The following module variables must be defined for {ConstHelper} to work:
  #
  #   - `@@model_class`: The {ActiveRecord::Base}-derived class to use for
  #     models.
  #   - `@@collection_sym`: The symbol to use for the collection constant (an
  #     array of all of the constant models).
  #   - `@@ids`: Hash with symbols as the keys and integers as the values.
  module ConstHelper
    # Hook run when `mod` extends this module.
    def self.extended(mod)
      mod.mattr_reader :model_class, :collection_sym, :ids
      # Create `<name>_ID` constants for each element of @@ids.
      mod.ids.each { |k, v| mod.const_set("#{k}_ID", v) } unless mod.const_defined?("#{mod.ids.keys.first}_ID")
    end

    # If the constant is undefined, pull the model from the database and set the
    # constant.
    def const_missing(sym)
      case
      when sym == collection_sym
        const_set(sym, model_class.all)
      when ids.has_key?(sym)
        const_set(sym, model_class.find(ids[sym]))
      else
        super(sym)
      end
    end
  end

  module Sections
    @@model_class = Section
    @@collection_sym = :SECTIONS
    @@ids = { STANDARD: 1, LATIN: 2, SMOOTH: 3, RHYTHM: 4 }

    extend ConstHelper
  end

  module Dances
    @@model_class = Dance
    @@collection_sym = :DANCES

    @@ids = {
      INTERNATIONAL_WALTZ: 1,
      INTERNATIONAL_TANGO: 2,
      INTERNATIONAL_FOXTROT: 3,
      INTERNATIONAL_VIENNESE_WALTZ: 4,
      INTERNATIONAL_QUICKSTEP: 5,
      INTERNATIONAL_CHA_CHA: 6,
      INTERNATIONAL_RUMBA: 7,
      INTERNATIONAL_SAMBA: 8,
      INTERNATIONAL_JIVE: 9,
      INTERNATIONAL_PASO_DOBLE: 10,
      AMERICAN_WALTZ: 11,
      AMERICAN_TANGO: 12,
      AMERICAN_FOXTROT: 13,
      AMERICAN_VIENNESE_WALTZ: 14,
      AMERICAN_CHA_CHA: 15,
      AMERICAN_RUMBA: 16,
      AMERICAN_SWING: 17,
      AMERICAN_BOLERO: 18,
      AMERICAN_MAMBO: 19
    }

    extend ConstHelper
  end

  module Levels
    @@model_class = Level
    @@collection_sym = :LEVELS

    @@ids = {
      NEWCOMER: 1,
      BRONZE: 2,
      SILVER: 3,
      GOLD: 4,
      OPEN: 5,
      PRE_CHAMPIONSHIP: 6,
      CHAMPIONSHIP: 7
    }

    extend ConstHelper
  end

  module Teams
    @@model_class = Team
    @@collection_sym = :TEAMS
    @@ids = {
      UNKNOWN: 1
    }

    extend ConstHelper
  end

  module Users
    @@model_class = User
    @@collection_sym = :USERS

    @@ids = {
      UNKNOWN_LEAD: 1,
      UNKNOWN_FOLLOW: 2
    }

    extend ConstHelper
  end
end
