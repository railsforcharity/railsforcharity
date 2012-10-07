namespace :db do
  desc "Refresh database, drop, create and migrate"
  task :refresh => [:development_environment_only, :drop, :create, :migrate, :import_skills]

  desc "Prepare test database"
  task :test_prep => :environment do
    Rake::Task['db:migrate'].invoke
    Rake::Task['test:prepare'].invoke
    run_command("bundle exec ruby script/one-off/20121006_create_roles.rb")
  end

  desc "Raise an error unless the Rails.env is development"
  task :development_environment_only do
    raise "Hey, development only, you monkey!" unless Rails.env.development?
  end

  desc "Importing skills data"
  task :import_skills do
    Rake::Task["data:import_skills"].execute
  end

  def run_command(command)
    puts command
    system(command)
  end
end
