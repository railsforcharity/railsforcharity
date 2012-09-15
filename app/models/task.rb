# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  task_type   :string(255)
#  status      :string(255)
#  hours       :string(255)
#  project_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Task < ActiveRecord::Base

  # Attributes
  attr_accessible :description, :hours, :name, :project_id, :task_type, :tag_names
  attr_accessor :tag_names
  after_save :assign_tags

  # Relations
  belongs_to :project
  belongs_to :creator, :class_name => 'User', :foreign_key => "created_by"
  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :tags, :through => :taggings

  # Validations
  validates :name, :presence => true, :length => { :in => 2..255}
  validates :description, :presence => true, :length => { :in => 20..2000 }
  validates :task_type, :presence => true
  validates :hours, :presence => true

  accepts_nested_attributes_for :tags

  private

  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(',').map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
  end


end
