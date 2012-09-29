class RenameColumnToTasks < ActiveRecord::Migration
  rename_column :tasks, :hours, :estimated_time
end
