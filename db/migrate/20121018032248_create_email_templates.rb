class CreateEmailTemplates < ActiveRecord::Migration
  def change
    create_table :email_templates do |t|

      t.timestamps
    end
  end
end
