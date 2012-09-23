class ChangeDataTypeForUserBio < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.change :bio, :text
    end
  end
end
