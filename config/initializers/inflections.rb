# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

module ActiveSupport
  module Inflector
    # Returns the ordinal string corresponding to the receiver integer.
    #
    # Internationalized from
    # http://kalmbach.wordpress.com/2013/01/08/ordinalize-numbers-in-current-locale/
    #
    # Uses English by default, but can be customized by adding
    def ordinalize(number)
      abs_number = number.to_i.abs
      rules = I18n.t 'number.ordinals', :default => ""

      # Assume English for compat
      rules = {
        :'\A\d{0,}(11|12|13)\z' => "%dth",
        :'\A\d{0,}1\z'  => "%dst",
        :'\A\d{0,}2\z'  => "%dnd",
        :'\A\d{0,}3\z'  => "%drd",
        :other => "%dth"
      } if rules.empty?

      match = rules.find do |rule|
        Regexp.new(rule[0].to_s).match(abs_number.to_s)
      end

      match = match && match[1] || rules[:other]

      match % number
    end
  end
end
