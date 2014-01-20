module ResultsScrapers
  extend ActiveSupport::Autoload

  class ScrapeError < StandardError; end

  autoload :Importer
  autoload :ZSConcepts, 'results_scrapers/zsconcepts'
end
