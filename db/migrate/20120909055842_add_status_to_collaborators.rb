class AddStatusToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :status, :string
  end
end
