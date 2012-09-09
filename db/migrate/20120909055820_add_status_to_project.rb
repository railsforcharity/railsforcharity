class AddStatusToProject < ActiveRecord::Migration
  def change
    add_column :projects, :website, :string
    add_column :projects, :repository_name, :string
    add_column :projects, :status, :string
    add_column :projects, :video, :string
  end
end
