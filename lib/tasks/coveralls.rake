if Rails.env.development? or Rails.env.test?
  require 'coveralls/rake/task'
  Coveralls::RakeTask.new
  task :test_with_coveralls => ['db:setup', 'spec', :cucumber, 'coveralls:push']
end
