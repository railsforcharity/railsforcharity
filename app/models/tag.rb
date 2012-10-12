# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tag_type   :string(255)
#  color      :string(255)
#

class Tag < ActiveRecord::Base
  # Attributes
  attr_accessible :name, :tag_type, :color

  # Relations
  has_many :taggings, :dependent => :destroy
  has_many :projects, :through => :taggings, :source => :taggable, :source_type => 'Project'
  has_many :tasks, :through => :taggings, :source => :taggable, :source_type => 'Task'

  #Named scopes
  scope :name_like, lambda { |n| where("name ilike ?", "%#{n}%") } # WARN: Potential DB Change Problem

  # Callbacks
  before_create :generate_color

  def generate_color
    self.color ||= "%06x" % (rand * 0xffffff)
  end
end
