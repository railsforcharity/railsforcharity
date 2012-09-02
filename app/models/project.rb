class Project < ActiveRecord::Base
  attr_accessible :description, :name

  #Relations
  has_and_belongs_to_many :users
end
