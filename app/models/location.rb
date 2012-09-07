# == Schema Information
#
# Table name: locations
#
#  id             :integer          not null, primary key
#  address_line1  :string(255)
#  address_line2  :string(255)
#  city           :string(255)
#  state          :string(255)
#  postal         :string(255)
#  country        :string(255)
#  locatable_type :string(255)
#  locatable_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Location < ActiveRecord::Base
  attr_accessible :address_line1, :address_line2, :city, :country, :locatable_id, :locatable_type, :postal, :state

  # Relations
  belongs_to :locatable, :polymorphic => true

  # Validations
  validates :country, :presence => true

end
