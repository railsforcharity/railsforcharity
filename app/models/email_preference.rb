# == Schema Information
#
# Table name: email_preferences
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  email_type  :integer
#  entity_id   :integer
#  entity_type :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class EmailPreference < ActiveRecord::Base
  attr_accessible :email_type, :entity_id, :entity_type, :user_id

  # Relations
  belongs_to :preferencable, polymorphic: true
end
