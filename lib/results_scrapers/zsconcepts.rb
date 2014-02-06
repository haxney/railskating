require 'net/http'

module ResultsScrapers::ZSConcepts
  # Base URI of all ZSConcepts results pages
  URI_BASE = 'http://www.dance.zsconcepts.com/results/'

  # Format to use for building competition URIs.
  COMP_FORMAT = URI_BASE + '%s/'

  # Format to use for building event URIs.
  EVENT_FORMAT = COMP_FORMAT + 'event%s.html'

  # Returns the competition URL for `comp` on this site.
  def self.comp_url(comp)
    COMP_FORMAT % comp
  end

  # Returns the event URL for `event` in `comp` on this site.
  def self.event_url(comp, event)
    EVENT_FORMAT % [comp, event]
  end

  # Returns a regular expression which matches the competition URLs.
  def self.comp_url_matcher
    %r{#{URI_BASE}([^/]+)}
  end

  def self.event_url_matcher
    %r{#{URI_BASE}([^/]+)/event(.+)\.html}
  end

  # Scrape a competition, including all of its events, usig ZSConcepts.
  #
  # Competition results pages have the form:
  #
  #     http://www.dance.zsconcepts.com/results/<comp>/
  #
  # This function requests that page and scrapes the results to find a list of
  # events, and then fetches each event page and scrapes that.
  #
  # @param [String] comp The name of the competition, as it appears on
  #   ZSConcepts.
  #
  # @return [Hash] See the output of {scrape_comp}. The `:events` key is
  #   populated with the contents of the scraped event pages. It is an array of
  #   "event hashes".
  def self.fetch_and_scrape_comp(comp)
    uri = URI(comp_url(comp))
    req = Net::HTTP::Get.new(uri)

    # Need to set the referer header in order to get the correct page.
    # ZSConcepts will redirect to the index if there is no referer.
    req['Referer'] = comp_url(comp)
    res = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }

    comp_data = scrape_comp(Nokogiri::HTML(res.body))
    comp_data[:events].each do |event|
      event.merge!(fetch_and_scrape_event(comp, event[:number]))
    end
    comp_data
  end

  # Scrape a given event from a competition usig ZSConcepts.
  #
  # Results pages have the form:
  #
  #     http://www.dance.zsconcepts.com/results/<comp>/event<num>.html
  #
  # This function requests that page and scrapes the results
  #
  # @param [String] comp The name of the competition, as it appears on
  #   ZSConcepts.
  # @param [Integer] event The event number.
  # @return [Hash] See the output of {scrape_event}
  def self.fetch_and_scrape_event(comp, event)
    uri = URI(event_url(comp, event))
    req = Net::HTTP::Get.new(uri)

    # Need to set the referer header in order to get the correct page.
    # ZSConcepts will redirect to the index if there is no referer.
    req['Referer'] = comp_url(comp)
    res = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }

    scrape_event(Nokogiri::HTML(res.body))
  end

  # Scrapes a Nokogiri document parsed from a ZSConcepts event results page.
  #
  # @param [Nokogiri::HTML::Document] doc A document containing a parsed
  #   ZSConcepts results page.
  #
  # @return [Hash] A hash with the following keys:
  #
  #   - `:number` The number of the event.
  #   - `:level` The level of the event.
  #   - `:section` The section of the event.
  #   - `:dances` Array of the dances of the event, in the order they appear on
  #               the page.
  #   - `:rounds` Array of "round hashes" as returned from
  #               {scrape_prelim_round} and {scrape_final_round}.
  def self.scrape_event(doc)
    event = {}

    title = doc.css('body title').first.content
    md = /Event #([0-9]+): (.+?) (.+?) (.+)/.match(title)
    event[:number] = md[1].to_i
    event[:level] = md[2]
    event[:section] = md[3]
    event[:dances] = md[4].split('/').map { |d| map_dance_name(d) }

    # Need to know whether this is a linked-dance event. The HTML don't contain
    # enough information to figure out which table is for a preliminary round and
    # which is for a final.
    linked_event = event[:dances].length > 1

    prelim_tables = doc.css('table h3+table')

    # The last table in a non-linked event is the final-round table.
    prelim_tables = prelim_tables[0..-2] unless linked_event
    event[:rounds] = prelim_tables.map do |table|
      scrape_prelim_round(table)
    end

    if linked_event
      round = {}
      doc.css('table h4+table').select do |t|
        t.previous.content != 'Final'
      end.each do |table|
        round = scrape_final_round(table,
                                   round,
                                   map_dance_name(table.previous.content),
                                   true)
      end
      event[:rounds] << round
    else
      final_table = doc.css('table h3+table').last
      event[:rounds] << scrape_final_round(final_table,
                                           {},
                                           event[:dances].first,
                                           false)
    end

    event
  end

  # Scrape the table of a preliminary round.
  #
  # @return [Hash] A hash with the keys:
  #   - `:number` The number of the round.
  #   - `:final` False, since this is a preliminary round.
  #   - `:judges` Array of (shorthand) judge names, in the order they appear on
  #               the page.
  #   - `:dances` Array of dances, in the order they appear on the page.
  #   - `:couples` Array of "couple hashes" as returned by {scrape_couples}.
  def self.scrape_prelim_round(table)
    round = {}
    round[:number] = /Round ([0-9]+)/.match(table.previous.content)[1].to_i
    round[:final] = false

    # Need to store this as a variable because {#shift} doesn't remove elements
    # from `table.children`.
    rows = table.children
    # First row is the list of dances
    dance_row = rows.shift
    num_judges = dance_row.children[1]['colspan'].to_i

    # First element is empty
    dances = dance_row.children.drop(1).map { |d| map_dance_name(d.content) }
    round[:dances] = dances

    # First element of the judge row is empty
    judges = rows.shift.children[1..num_judges].map(&:content)
    round[:judges] = judges
    round[:couples] = scrape_couples(rows, dances, judges)
    round
  end

  # Scrape the table of a final round. For linked events, this function will be
  # called multiple times for each round, since the marks for each dance are
  # from a separate table. Each invocation will build on the previous one.
  #
  # @param [Nokogiri::XML::Element] table Table from which to parse the final
  #   round.
  # @param [Hash] round Pre-built hash which will be extended to include the
  #   parsed information.
  # @param [String] dance The dance referenced by the table.
  #
  # @return [Hash] A hash with the keys:
  #   - `:number` The number of the round.
  #   - `:final` True, since this is a final round.
  #   - `:judges` Array of (shorthand) judge names, in the order they appear on
  #               the page.
  #   - `:dances` Array of dances, in the order they appear on the page.
  #   - `:couples` Array of "couple hashes" as returned by {scrape_couples}.
  def self.scrape_final_round(table, round, dance, linked)
    round[:final] = true
    number_elem = if linked
                    # This will only work the first time, the subsequent tables
                    # are preceeded only by the dance name, not the round
                    # number.
                    table.previous.previous.content
                  else
                    table.previous.content
                  end
    round[:number] ||= /Round ([0-9]+)/.match(number_elem)[1].to_i
    rows = table.children

    # First row is the headers (including the judges)
    header_row = rows.shift
    judges = header_row.children.drop(1)
      .map(&:content).take_while { |h| h != 'Place' }
    round[:judges] = judges
    round[:dances] ||= []
    round[:dances] << dance
    couples_tmp = scrape_couples(rows, [dance], judges)
    round[:couples] ||= couples_tmp
    merge_couples!(round[:couples], couples_tmp)
    round
  end

  # Merge two couples arrays together by combining the `:dances` element of each
  # of the couples.
  #
  # @param [Array<Hash>] h1 First array to merge. The hashes within this array
  #   are modified.
  # @param [Array<Hash>] h2 Second array to merge. This array is not modified.
  def self.merge_couples!(h1, h2)
    h1.each_index { |i| h1[i][:dances].merge!(h2[i][:dances]) }
  end

  # Scrape the contents of a round table, either preliminary or final.
  #
  # @param [Array<Nokogiri::XML::Node>] rows Rows of the table, starting with
  #   the first couple.
  # @param [Array<String>] dances Array of the dances in this table, in the
  #   order they appear on the page.
  # @param [Array<String>] judges The (shorthand) names of the judges in this
  #   round.
  #
  # @return [Array<Hash>] Array of "couple hashes", each of which has the
  #   following keys:
  #
  #   - `:number` The number of the couple
  #   - `:no_name` No name information was available for the couple
  #   - `:lead_name` The name of the leader
  #   - `:lead_team` The team of the leader
  #   - `:follow_name` The name of the follower
  #   - `:follow_team` The team of the follower
  #   - `:dances` The value returned from {scrape_marks_row}
  #   - `:recall_or_place` Whether the couple was recalled, as a boolean or
  #                        the placement of the couple, as an integer.
  def self.scrape_couples(rows, dances, judges)
    rows.map do |row|
      couple = {}
      cols = row.children
      name_elem = cols.shift.content
      couple[:number] = name_elem.to_i
      case name_elem
      when /[0-9]+ \(no name available\)/
        couple[:no_name] = true
      when /[0-9]+ (.+) \((.+)\) & (.+) \((.+)\)/
        couple[:lead_name] = $1
        couple[:lead_team] = $2
        couple[:follow_name] = $3
        couple[:follow_team] = $4
      else
        raise ResultsScrapers::ScrapeError, "Unexpected couple name '#{name_elem}'"
      end

      couple[:dances] = scrape_marks_row(cols, judges, dances)
      extra = cols[judges.length * dances.length].content
      couple[:recall_or_place] = case extra
                                 when '' then false
                                 when /R/ then true
                                 when /[0-9]+/ then extra.to_i
                                 else
                                   raise ResultsScrapers::ScrapeError, "Unexpected extra column '#{extra}'"
                                 end
      couple
    end
  end

  # Scrape a row of marks into a hash.
  #
  # @param [Array<Nokogiri::XML::Node>] cols The elements of the table which
  #   contain marks. This should omit the first column, which contains the couple
  #   name.
  # @param [Array<String>] judges The number of judges.
  # @param [Array<String>] dances The dances, in the order that they appear on the
  #   page.
  #
  # @return [{String => { String => Boolean, Integer }}] Hash with the dance name
  #   as keys and hases as the values. The inner hashes have the judge name as the
  #   keys and `true`, `false`, or the place assigned by the judge as the values.
  def self.scrape_marks_row(cols, judges, dances)
    start_idx = 0
    marks = {}
    dances.each do |dance|
      marks[dance] = {}
      (start_idx..start_idx + judges.length - 1).each do |i|
        res = case cols[i].content
              when '' then false
              when 'X' then true
              when /^[0-9]+$/ then cols[i].content.to_i
              else
                raise ResultsScrapers::ScrapeError, "Unexpected judge mark '#{cols[i].content}"
              end
        marks[dance][judges[i % judges.length]] = res
      end
      start_idx += judges.length
    end
    marks
  end

  # Scrape a Nokogiri document parsed from a ZSConcepts competition overview
  # page.
  #
  # @param [Nokogiri::HTML::Document] doc A document containing a parsed
  #   ZSConcepts competition page.
  #
  # @return [Hash] A hash with the following keys:
  #
  #   - `:name` The name of the competition.
  #   - `:year` The year of the competition, as an Integer
  #   - `:judges` A hash returned from {scrape_judge}.
  #   - `:events` An array of hashes with the keys `:number` (the event number
  #               as an Integer) and `:file_name` (the name of the file which
  #               contains the event).
  def self.scrape_comp(doc)
    comp = {}

    title =  doc.css('h1').first.content.strip.split
    comp[:name] = title[0..-2].join(" ")
    comp[:year] = title.last.to_i
    judge_table = doc.css('table h2+table').first
    comp[:judges] = judge_table.css('tr').map { |row| scrape_judge(row) }
    comp[:events] = []

    doc.css('ol li a').each do |link|
      md = /event(\d+)\.html/.match(link['href'])
      raise ResultsScrapers::ScrapeError, "Unexpected link format: '#{link['href']}'" unless md
      comp[:events] << { number: md[1].to_i, file_name: link['href'] }
    end
    comp
  end

  # Scrapes a single judge from a row in the judges table.
  #
  # @param [Nokogiri::XML::Element] row A `<tr>` element from the judges table.
  #
  # @return [Hash] A hash with the keys:
  #
  #   - `:shorthand` The shorthand name of the judge.
  #   - `:name` The name of the judge
  def self.scrape_judge(row)
    {
      shorthand: row.children[0].content.strip,
      name: row.children[1].content.strip
    }
  end

  # Convert a ZSConcepts dance name to a Railskating dance name. Some dance
  # names are different, and must be converted. For example, ZSConcepts calls
  # the dance "Cha-cha" while Railskating calls it "Cha Cha".
  #
  # @param [String] dance The ZSConcepts name of the dance.
  #
  # @return [String] The Railskating name of the dance.
  def self.map_dance_name(dance)
    case dance
    when /cha-cha/i then "Cha Cha"
    else dance
    end
  end
end
