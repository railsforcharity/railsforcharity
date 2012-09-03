def alias_task(name, old_name)
  t = Rake::Task[old_name]
  desc t.full_comment if t.full_comment
  task name, *t.arg_names do |_, args|
    # values_at is broken on Rake::TaskArguments
    args = t.arg_names.map { |a| args[a] }
    t.invoke(args)
  end
end

namespace :db do
  namespace :test do
    alias_task('old_prepare', 'prepare')

    desc "Customized task to load skills after preparing database"
    task :prepare do
      Rake::Task['db:test:old_prepare'].invoke
      Rake::Task['data:import_skills'].invoke
    end
  end
end
