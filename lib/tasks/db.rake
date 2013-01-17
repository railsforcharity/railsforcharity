namespace :db do
  desc "Refresh database, drop, create and migrate"
  task :refresh => [:development_environment_only, :drop, :create, :migrate, :import_skills]

  desc "Prepare test database"
  task :test_prep => :environment do
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:test:prepare'].invoke
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

# lib/tasks/kill_postgres_connections.rake
task :kill_postgres_connections => :environment do
  db_name = "#{File.basename(Rails.root)}_#{Rails.env}"
  sh = <<EOF
ps xa \
  | grep postgres: \
  | grep #{db_name} \
  | grep -v grep \
  | awk '{print $1}' \
  | xargs kill
EOF
  puts `#{sh}`
end

task "db:drop" => :kill_postgres_connections