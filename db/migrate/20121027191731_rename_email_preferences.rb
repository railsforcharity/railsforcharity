class RenameEmailPreferences < ActiveRecord::Migration
  def change
    remove_column :email_preferences, :email_type
    remove_column :email_preferences, :setting_value
    rename_table :email_preferences, :preferences

    execute "CREATE EXTENSION hstore"
    add_column :preferences, :properties, :hstore
    execute "CREATE INDEX preferences_properties ON preferences USING GIN(properties)"
  end
end
