require 'coveralls/rake/task'
Coveralls::RakeTask.new
task :test_with_coveralls => ['spec:models', :features, 'coveralls:push']
