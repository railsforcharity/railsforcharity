class UpdateEmailPreferences < ActiveRecord::Migration
  def change
    drop_table :email_templates
    add_column :email_preferences, :setting_value, :boolean
  end
end
