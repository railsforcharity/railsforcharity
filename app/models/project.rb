class Project < ActiveRecord::Base
  attr_accessible :description, :name, :title

  # Relations
  has_and_belongs_to_many :users

  # Validations
  validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..25 }
  validates :title, :presence => true, :length => { :in => 10..140 }
  validates :description, :presence => true, :length => { :in => 50..2000 }

end
