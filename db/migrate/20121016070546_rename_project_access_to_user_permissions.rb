class RenameProjectAccessToUserPermissions < ActiveRecord::Migration
  def change
    rename_table :project_accesses, :user_permissions
    add_column :user_permissions, :entity_type, :string
    rename_column :user_permissions, :project_id, :entity_id
  end
end
