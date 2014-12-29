namespace :db do
  namespace :views do
    desc "Load views from the views.sql file"
    task :load => [:environment, :load_config] do
      puts "-- Loading views.sql"
      view_file = File.join(ActiveRecord::Tasks::DatabaseTasks.db_dir, "views.sql")
      ActiveRecord::Tasks::DatabaseTasks.load_schema_current(:sql, view_file)
    end
  end

  # Redefine `:setup` to run `db:views:load`
  task :setup do
    Rake::Task['db:views:load'].invoke
  end
end
