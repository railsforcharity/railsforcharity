class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end
end
