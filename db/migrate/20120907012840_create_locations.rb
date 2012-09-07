class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :state
      t.string :postal
      t.string :country
      t.string :locatable_type
      t.integer :locatable_id

      t.timestamps
    end
  end
end
