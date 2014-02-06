# Turn off rspec verbosity, so that the
# resultant rspec command, and all the
# spec names, are not echoed to stdout.
# See http://bit.ly/MoOoB3 -Jared 2012-07-19
if defined? RSpec and (Rails.env.development? or Rails.env.test?)
  prereqs = Rake::Task[:spec].prerequisites
  task(:spec).clear
  RSpec::Core::RakeTask.new(:spec => prereqs) do |t|
    t.verbose = false
  end
end
