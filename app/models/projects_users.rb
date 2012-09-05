# == Schema Information
#
# Table name: projects_users
#
#  id         :integer          not null, primary key
#  project_id :integer
#  user_id    :integer
#

class ProjectsUsers < ActiveRecord::Base
  attr_accessible :project_id, :user_id

  # Associations
  belongs_to :user
  belongs_to :project

  # Validations
  validates :user_id, :project_id, :presence => true

end
