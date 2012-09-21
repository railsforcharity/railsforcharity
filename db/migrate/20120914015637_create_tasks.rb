class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.string :task_type
      t.integer :status
      t.integer :hours
      t.integer :project_id
      t.integer :created_by
      t.integer :assigned_to

      t.timestamps
    end
  end
end
