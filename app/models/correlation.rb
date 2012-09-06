class Correlation < ActiveRecord::Base
  attr_accessible :project_id, :user_id

  # Relations
  belongs_to :user
  belongs_to :project

end
