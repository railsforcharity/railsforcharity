class CreateEmailPreferences < ActiveRecord::Migration
  def change
    create_table :email_preferences do |t|
      t.integer :user_id
      t.integer :email_type
      t.integer :entity_id
      t.string :entity_type

      t.timestamps
    end
  end
end
