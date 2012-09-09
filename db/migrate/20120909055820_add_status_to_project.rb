class AddStatusToProject < ActiveRecord::Migration
  def change
    add_column :projects, :website, :string
    add_column :projects, :profile_url, :string
    add_column :projects, :status, :string
    add_column :projects, :video, :string
  end
end
