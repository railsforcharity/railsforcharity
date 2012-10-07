class AddRoleToCollaborators < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :description
    end

    add_column :collaborators, :role_id, :integer
  end
end
