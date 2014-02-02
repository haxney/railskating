require 'coveralls/rake/task'
Coveralls::RakeTask.new
task :test_with_coveralls => ['db:setup', 'spec:models', :features, 'coveralls:push']
