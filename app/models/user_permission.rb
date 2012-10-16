# == Schema Information
#
# Table name: user_permissions
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :string(255)
#  role_id     :integer
#  entity_type :string(255)
#  entity_id   :integer
#

class UserPermission < ActiveRecord::Base
  attr_accessible :user, :entity, :entity_type, :entity_id, :user_id, :role_id

  # Relations
  belongs_to :user
  belongs_to :entity, :polymorphic => true

  # Validations
  validates :user_id, presence: true
  validates :entity_type, presence: true
  validates :entity_id, presence: true

end
