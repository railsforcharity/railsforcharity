class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.string :task_type
      t.string :status
      t.integer :hours
      t.integer :project_id

      t.timestamps
    end
  end
end
