class AddSlugToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio, :string
    add_column :users, :website, :string
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true
  end
end
