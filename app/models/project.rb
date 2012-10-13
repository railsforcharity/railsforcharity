# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  title       :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  website     :string(255)
#  profile_url :string(255)
#  status      :string(255)
#  video       :string(255)
#

class Project < ActiveRecord::Base

  # Attributes
  attr_accessible :description, :name, :title, :collaborator_tokens, :avatar_attributes, :task_attributes, :category_names, :technology_names, :website, :profile_url, :video, :terms, :status
  attr_reader :collaborator_tokens
  attr_accessor :category_names, :technology_names

  # Relations
  has_many :project_accesses
  has_many :users, :through => :project_accesses
  has_one :location, :as => :locatable, :dependent => :destroy
  has_one :avatar, :as => :avatarable, :dependent => :destroy
  belongs_to :creator, :class_name => 'User', :foreign_key => "created_by"
  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :tags, :through => :taggings
  has_many :tasks

  has_reputation :votes, source: :user, aggregated_by: :sum

  # Validations
  validates :name, :presence => true, :uniqueness => true, :length => { :in => 2..40 }
  validates :title, :presence => true, :length => { :in => 10..140 }
  validates :description, :presence => true, :length => { :in => 50..2000 }
  validates :website, :length => { :maximum => 500 }
  validates :video, :length => { :maximum => 500 }
  validates :profile_url, :presence => true, :uniqueness => true, :length => { :in => 2..25 }
  validates_acceptance_of :terms, :on => :create

  accepts_nested_attributes_for :users, :avatar, :location

  # Named Scopes
  scope :name_like, lambda { |n| where("name ilike ?", "%#{n}%") } # WARN: Potential DB Change Problem

  # Callbacks
  after_save lambda { make_admin(creator) }, :assign_tags

  # Attr Writers
  def collaborator_tokens=(ids_csv)
    self.user_ids = ids_csv.split(',')
  end

  def project_access_obj(user)
    ProjectAccess.find_by_project_id_and_user_id(self, user)
  end

  def get_role(user)
    project_access_obj(user).try(:role_id)
  end

  # make_admin(user), make_collaborator(user)
  #
  # def make_admin(user)
  #   project_access = project_access_obj(user) || self.project_accesses.build(:user => user)
  #   project_access.role_id = Role::TYPES[:project_admin]
  #   project_access.save
  # end
  [:admin, :collaborator].each do |role_name|
    define_method("make_#{role_name}") do |user|
      project_access = project_access_obj(user) || self.project_accesses.build(:user => user)
      project_access.role_id = Role::TYPES[:"project_#{role_name}"]
      project_access.save
    end

    # def is_admin?(user)
    #   self.get_role(user) == Role::TYPES[:project_admin]
    # end
    define_method("is_#{role_name}?") do |user|
      self.get_role(user) == Role::TYPES[:"project_#{role_name}"]
    end
  end

  def categories
    self.tags.where(:tag_type => 'project')
  end

  def technologies
    self.tags.where(:tag_type => 'technology')
  end

  private

  def assign_tags
    new_tags = []

    if @category_names
      @category_names.split(',').map do |name|
        new_tags << ['project', name]
      end
    end

    if @technology_names
      @technology_names.split(',').map do |name|
        new_tags << ['technology', name]
      end
    end

    self.tags = new_tags.map do |tag|
      Tag.find_or_create_by_name(tag[1], :tag_type => tag[0])
    end
  end

end
