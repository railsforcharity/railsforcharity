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
#

class Project < ActiveRecord::Base
  attr_accessible :description, :name, :title, :user_ids, :avatar_attributes, :location_attributes

  # Relations
  has_many :correlations
  has_many :users, :through => :correlations
  has_one :location, :as => :locatable, :dependent => :destroy
  has_one :avatar, :as => :avatarable, :dependent => :destroy
  has_reputation :votes, source: :user, aggregated_by: :sum



  # Validations
  validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..25 }
  validates :title, :presence => true, :length => { :in => 10..140 }
  validates :description, :presence => true, :length => { :in => 50..2000 }

  accepts_nested_attributes_for :users, :avatar, :location


end
