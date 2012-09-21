class AddCreatedByToComments < ActiveRecord::Migration
  def change
    add_column :comments, :created_by, :integer
  end
end
