# For the seed data, the ID of each dance, section, or level will always be
# the same, so define them here.
#
# After trying for a while to get some nice metaprogramming solution whereby I
# could define only the `@@model_class` and `@@ids` and have magic take care of
# the rest; I've resorted just to copying and pasting. Maybe someday, when my
# Ruby metaprogramming foo is stronger, I'll come back and fix this.
module Constants
  module Sections
    @@model_class = Section
    @@ids = { STANDARD: 1, LATIN: 2, SMOOTH: 3, RHYTHM: 4 }

    # Create `<name>_ID` constants for each element of @@ids.
    @@ids.each { |k, v| const_set("#{k}_ID", v) } unless const_defined?("#{@@ids.keys.first}_ID")

    # If the constant is undefined, pull the model from the database and set the
    # constant.
    def self.const_missing(sym)
      case
      when sym == :SECTIONS
        const_set(sym, @@model_class.all)
      when @@ids.has_key?(sym)
        const_set(sym, @@model_class.find(@@ids[sym]))
      else
        super(sym)
      end
    end
  end

  module Dances
    @@model_class = Dance

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

    # Create `<name>_ID` constants for each element of @@ids.
    @@ids.each { |k, v| const_set("#{k}_ID", v) } unless const_defined?("#{@@ids.keys.first}_ID")

    # If the constant is undefined, pull the model from the database and set the
    # constant.
    def self.const_missing(sym)
      case
      when sym == :DANCES
        const_set(sym, @@model_class.all)
      when @@ids.has_key?(sym)
        const_set(sym, @@model_class.find(@@ids[sym]))
      else
        super(sym)
      end
    end
  end

  module Levels
    @@model_class = Level

    @@ids = {
      NEWCOMER: 1,
      BRONZE: 2,
      SILVER: 3,
      GOLD: 4,
      OPEN: 5,
      PRE_CHAMPIONSHIP: 6,
      CHAMPIONSHIP: 7
    }

    # Create `<name>_ID` constants for each element of @@ids.
    @@ids.each { |k, v| const_set("#{k}_ID", v) } unless const_defined?("#{@@ids.keys.first}_ID")

    # If the constant is undefined, pull the model from the database and set the
    # constant.
    def self.const_missing(sym)
      case
      when sym == :LEVELS
        const_set(sym, @@model_class.all)
      when @@ids.has_key?(sym)
        const_set(sym, @@model_class.find(@@ids[sym]))
      else
        super(sym)
      end
    end
  end
end
