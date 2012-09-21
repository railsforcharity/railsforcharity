# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  task_type   :string(255)
#  status      :integer
#  hours       :integer
#  project_id  :integer
#  created_by  :integer
#  assigned_to :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Task < ActiveRecord::Base

  # Constants (should always be declared at the top)
  STATUSES = {
    open: 1,
    ongoing: 2,
    closed: 3
  }

  # Attributes
  attr_accessible :description, :hours, :name, :project_id, :task_type, :tag_names, :content
  attr_accessor :tag_names
  after_save :assign_tags

  # Relations
  belongs_to :project
  belongs_to :creator, :class_name => 'User', :foreign_key => "created_by"
  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :tags, :through => :taggings
  has_many :comments, as: :commentable

  # Validations
  validates :name, :presence => true, :length => { :in => 2..255 }
  validates :description, :presence => true, :length => { :minimum => 20 }
  validates :task_type, :presence => true
  validates :hours, :presence => true

  accepts_nested_attributes_for :tags

  # Named Scopes
  scope :open_tasks, where(status: STATUSES[:open])
  scope :closed, where(status: STATUSES[:closed])
  scope :ongoing, where(status: STATUSES[:ongoing])

  # Callbacks
  #before_save :make_open

  private

  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(',').map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
  end
end
