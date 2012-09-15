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
  attr_accessible :description, :name, :title, :collaborator_tokens, :avatar_attributes, :tag_names, :website, :profile_url, :video, :terms
  attr_reader :collaborator_tokens
  attr_accessor :tag_names
  after_save :assign_tags

  # Relations
  has_many :collaborators
  has_many :users, :through => :collaborators
  has_one :location, :as => :locatable, :dependent => :destroy
  has_one :avatar, :as => :avatarable, :dependent => :destroy
  belongs_to :creator, :class_name => 'User', :foreign_key => "created_by"
  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :tags, :through => :taggings

  has_reputation :votes, source: :user, aggregated_by: :sum

  # Validations
  validates :name, :presence => true, :uniqueness => true, :length => { :in => 2..40 }
  validates :title, :presence => true, :length => { :in => 10..140 }
  validates :description, :presence => true, :length => { :in => 50..2000 }
  validates :website, :length => { :maximum => 500 }
  validates :video, :length => { :maximum => 500 }
  validates :profile_url, :presence => true, :uniqueness => true, :length => { :in => 2..25 }
  validates_acceptance_of :terms, :on => :create

  accepts_nested_attributes_for :users, :avatar, :location, :tags

  # Named Scopes
  scope :name_like, lambda { |n| where("name ilike ?", "%#{n}%") } # WARN: Potential DB Change Problem

  # Attr Writers
  def collaborator_tokens=(ids_csv)
    self.user_ids = ids_csv.split(',')
  end

  private

  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(',').map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
  end

end
