# == Schema Information
#
# Table name: skills
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  description   :string(255)
#  category      :string(255)
#  is_deprecated :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Skill < ActiveRecord::Base
  attr_accessible :id, :category, :name, :description, :is_deprecated
end
