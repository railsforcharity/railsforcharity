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

  CATEGORIES = {
    programming: 1,
    designing: 2,
    testing: 3,
    art: 4,
    management: 5,
    marketing: 6,
    finance: 7,
    legal: 8
  }

  TYPES = {
    feature: 1,
    bug: 2,
    chore: 3,
    enhancement: 4
  }

  # Attributes
  attr_accessible :description, :estimated_hours, :estimated_minutes, :name, :project_id, :category, :task_type, :tag_names
  attr_accessor :tag_names, :estimated_hours, :estimated_minutes

  # Relations
  belongs_to :project
  belongs_to :creator, :class_name => 'User', :foreign_key => "created_by"
  belongs_to :assignee, :class_name => 'User', :foreign_key => "assigned_to"
  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :tags, :through => :taggings
  has_many :comments, as: :commentable

  # Validations
  validates :name, :presence => true, :length => { :in => 2..255 }
  validates :description, :presence => true, :length => { :minimum => 20 }
  validates :category, :presence => true
  validates :task_type, :presence => true, :if => :programming_task?

  accepts_nested_attributes_for :tags

  # Callbacks
  before_save :set_estimated_time
  after_save :assign_tags

  # Named Scopes
  scope :open_tasks, where(status: STATUSES[:open])
  scope :closed, where(status: STATUSES[:closed])
  scope :ongoing, where(status: STATUSES[:ongoing])

  def set_estimated_time
    self.estimated_time = @estimated_hours.to_i * 60 + @estimated_minutes.to_i
  end

  def estimated_hours
    self.estimated_time.to_i / 60 if self.estimated_time
  end

  def estimated_minutes
    self.estimated_time.to_i % 60 if self.estimated_time
  end

  private

  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(',').map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
  end

  def programming_task?
    self.category == CATEGORIES[:programming]
  end

end
