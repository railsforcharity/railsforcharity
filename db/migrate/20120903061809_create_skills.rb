class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.string :description
      t.string :category
      t.boolean :is_deprecated

      t.timestamps
    end
  end
end
