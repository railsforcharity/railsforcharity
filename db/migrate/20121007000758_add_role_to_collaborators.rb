class AddRoleToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :role_id, :integer
    rename_table :collaborators, :project_accesses
  end
end
