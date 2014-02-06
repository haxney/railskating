module ScrapingFeaturesSupport

  # Return the local file path of the competition which would be on the web.
  def comp_file_path(mod_name, comp)
    Rails.root.join('features', 'results_scrapers',
                    mod_name.downcase, comp, "index.html")
  end

  # Return the local file path of the event which would be on the web.
  def event_file_path(mod_name, comp, event)
    Rails.root.join('features', 'results_scrapers',
                    mod_name.downcase, comp, "event#{event}.html")
  end

  # Returns the number of event files for a given `mod_name` and `comp`.
  def event_files_for(mod_name, comp)
    dir = Rails.root.join('features', 'results_scrapers',
                          mod_name.downcase, comp)
    dir.children.reject { |c| /.*index.html$/ =~ c.to_s }
  end

  # Use WebMock to stub the request for a competition.
  #
  # @param [String] mod_name The name of the module to use for fetching.
  # @param [String] comp The name of the competition.
  def stub_comp_request(mod_name, comp)
    mod = ResultsScrapers.const_get(mod_name.to_sym)
    comp_url = mod.method(:comp_url).call(comp)
    stub_request(:get, comp_url).
      to_return(body: File.new(comp_file_path(mod_name, comp)))
  end

  # Use WebMock to stub the requests for the events of a competition.
  #
  # @param [String] mod_name The name of the module to use for fetching.
  # @param [String] comp The name of the competition.
  # @param [Integer] num_events The number of events which will be requested.
  #
  # @return [WebMock::RequestStub] A newly-created stubbed request.
  def stub_event_requests(mod_name, comp, num_events)
    mod = ResultsScrapers.const_get(mod_name.to_sym)
    event_matcher = mod.method(:event_url_matcher).call()
    stub_request(:get, event_matcher)
      .to_return(body: lambda do |req|
                   md = event_matcher.match(req.uri.omit(:port).to_s)
                   File.new(event_file_path(mod_name, md[1], md[2]))
                 end)
      .times(num_events)
  end
end

World(ScrapingFeaturesSupport)
