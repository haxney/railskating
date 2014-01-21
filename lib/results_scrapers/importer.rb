module ResultsScrapers::Importer
  # Imports an event hash into the database.
  #
  # @param [Hash] hash A hash returned from a `scrape_event` function.
  # @param [Competition] comp The existing {Competition} model to associate this
  #   event with. All {Adjudicator}s must already exist.
  #
  # @return [Event] A newly-created {Event} filled in with information from
  #   `hash`.
  def self.import_event(hash, comp)
    comp.transaction do
      level = hash[:level].parameterize.underscore.upcase.to_sym
      event = comp.events.create(level: Constants::Levels.const_get(level),
                                 number: hash[:number])
      se_hash = {}
      hash[:dances].each_index do |i|
        dance = hash[:dances][i]
        dance_model = Dance.find_by!(name: hash[:section] + ' ' + dance)
        sub_event = event.sub_events.create(dance: dance_model,
                                            order: i)
        se_hash[dance] = sub_event
      end

      judge_hash = {}
      comp.adjudicators.each do |a|
        judge_hash[a.shorthand] = a
      end

      hash[:rounds].each { |r| import_round(r, event, se_hash, judge_hash) }
      event.save!
      event
    end
  end

  # Imports a single round into the database.
  #
  # @param [Hash] hash A hash returned from a `scrape_*_round` function.
  # @param [Event] event Event to which to add the round.
  # @param [{String => SubEvent}] se_hash A hash from dance names to {SubEvent}
  #   objects.
  # @param [{String => Adjudicator}] judge_hash A hash from judge shorthands to
  #   {Adjudicator} models.
  #
  # @return [Round] A newly-created {Round} imported from the hash.
  def self.import_round(hash, event, se_hash, judge_hash)
    round = event.rounds.create(number: hash[:number],
                                final: hash[:final],
                                adjudicators: hash[:judges].map { |j| judge_hash[j] },
                                # Just assume that exactly the number recalled
                                # were requested, since the real info is not
                                # present on the site.
                                requested: hash[:couples]
                                  .select { |c| c[:recall_or_place] }.length)
    sr_hash = Hash[se_hash.map do |dance, se|
      [dance, round.sub_rounds.create(sub_event: se)]
    end]

    hash[:couples].each do |couple_hash|
      no_name = couple_hash[:no_name]

      lead = if no_name
               Constants::Users::UNKNOWN_LEAD
             else
               lead_team = Team.find_or_create_by(name: couple_hash[:lead_team])
               # Assume that only first name and last name are present. If more
               # than two words, then the first word is the first name and all
               # remaining words are the last name.
               lead_names = couple_hash[:lead_name].split($;, 2)
               User.find_or_create_by(first_name: lead_names.first,
                                    last_name: lead_names.last,
                                    team: lead_team)
             end


      follow = if no_name
                 Constants::Users::UNKNOWN_FOLLOW
               else
                 follow_team = Team.find_or_create_by(name: couple_hash[:follow_team])
                 follow_names = couple_hash[:follow_name].split($;, 2)
                 User.find_or_create_by(first_name: follow_names.first,
                                        last_name: follow_names.last,
                                        team: follow_team)
               end
      couple = Couple.find_or_create_by(lead: lead,
                                        follow: follow,
                                        event: event,
                                        number: couple_hash[:number])
      round.couples << couple # Hopefully Rails takes care not to double-insert couples

      couple_hash[:dances].each do |d, marks|
        sub_round = sr_hash[d]
        marks.each do |judge, placement|
          # `mark` might be `false`, in which case a {Mark} object should not be
          # created.
          if placement
            placement = 0 if placement == true
            Mark.create(adjudicator: judge_hash[judge],
                        couple: couple,
                        sub_round: sub_round,
                        placement: placement)
          end
        end
      end
    end
  end

  # Imports a competition hash into the database.
  #
  # @param [Hash] hash A hash returned from a `scrape_comp` function.
  #
  # @return [Event] A newly-created {Competition} filled in with information
  #   from `hash`.
  def self.import_comp(hash)
  end
end
