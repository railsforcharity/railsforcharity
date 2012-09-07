class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.string :avatarable_type
      t.integer :avatarable_id
      t.string :image

      t.timestamps
    end
  end
end
