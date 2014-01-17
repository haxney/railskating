require 'yard'

YARD::Rake::YardocTask.new do |t|
  t.files   = ['app/**/*.rb', 'lib/**/*.rb',
               'features/**/*.feature', 'features/**/*.rb']
end
