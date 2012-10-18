class EmailPreference < ActiveRecord::Base
  attr_accessible :email_type, :entity_id, :entity_type, :user_id
end
