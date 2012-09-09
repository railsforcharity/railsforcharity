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
#

class Project < ActiveRecord::Base

  attr_accessible :description, :name, :title, :user_ids, :collaborator_tokens, :avatar_attributes, :location_attributes, :created_by
  attr_reader :collaborator_tokens

  # Relations
  has_many :collaborators
  has_many :users, :through => :collaborators
  has_one :location, :as => :locatable, :dependent => :destroy
  has_one :avatar, :as => :avatarable, :dependent => :destroy
  belongs_to :creator, :class_name => 'User', :foreign_key => "created_by"

  has_reputation :votes, source: :user, aggregated_by: :sum


  # Validations
  validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..25 }
  validates :title, :presence => true, :length => { :in => 10..140 }
  validates :description, :presence => true, :length => { :in => 50..2000 }

  accepts_nested_attributes_for :users, :avatar, :location

  # Attr Writers
  def collaborator_tokens=(ids_csv)
    self.user_ids = ids_csv.split(',')
  end

end
