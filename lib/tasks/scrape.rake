require 'results_scrapers'

namespace :scrape do
  desc "Scrape an entire competition"
  task :comp, [:comp] => :environment do |t, args|
    comp = ResultsScrapers::ZSConcepts.fetch_and_scrape_comp(args[:comp])
    ResultsScrapers::Importer.import_comp(comp)
  end

  desc "Scrape a single event"
  task :event, [:comp, :event, :num_judges] => :environment do |t, args|
    comp = Competition.find_or_create_by(name: args[:comp]) do |c|
      FactoryGirl.create_list(:adjudicator,
                              args[:num_judges].to_i,
                              competition: c)
    end

    event = ResultsScrapers::ZSConcepts.fetch_and_scrape_event(args[:comp],
                                                               comp.adjudicators.count)
    ResultsScrapers::Importer.import_event(event, comp)
  end
end
