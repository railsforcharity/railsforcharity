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
  attr_accessible :description, :name, :title, :user_ids

  # Relations
  has_many :correlations
  has_many :users, :through => :correlations
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  attr_writer :tags_names
  #after_save :assign_tags


  # Validations
  validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..25 }
  validates :title, :presence => true, :length => { :in => 10..140 }
  validates :description, :presence => true, :length => { :in => 50..2000 }

  accepts_nested_attributes_for :users


end
