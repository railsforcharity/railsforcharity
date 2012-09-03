class Skill < ActiveRecord::Base
  attr_accessible :id, :category, :name, :description, :is_deprecated
end
