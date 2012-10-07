# == Schema Information
#
# Table name: collaborators
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string(255)
#  role_id    :integer
#

class Collaborator < ActiveRecord::Base
  attr_accessible :project_id, :user_id, :role_id

  # Relations
  belongs_to :user
  belongs_to :project

  # Validations
  validates :user_id, presence: true
  validates :project_id, presence: true

end
