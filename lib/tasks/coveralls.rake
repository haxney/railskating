if Rails.env.development? or Rails.env.test?
  require 'coveralls/rake/task'
  Coveralls::RakeTask.new
  task :test_with_coveralls => ['spec', :cucumber, 'coveralls:push']
end
