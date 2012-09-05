namespace :db do
  desc "Refresh database, drop, create and migrate"
  task :refresh => [:development_environment_only, :drop, :create, :migrate]
  
  desc "Raise an error unless the Rails.env is development"
  task :development_environment_only do
    raise "Hey, development only, you monkey!" unless Rails.env.development?
  end

  desc "Importing skills data"
  task :import_skills do
    Rake::Task["data:import_skills"].execute
  end
end
