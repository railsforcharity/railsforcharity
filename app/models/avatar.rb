# == Schema Information
#
# Table name: avatars
#
#  id              :integer          not null, primary key
#  avatarable_type :string(255)
#  avatarable_id   :integer
#  image           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Avatar < ActiveRecord::Base
  attr_accessible :avatarable_id, :avatarable_type, :image, :remote_image_url

  # Relations
  belongs_to :avatarable, polymorphic: true

  mount_uploader :image, ImageUploader

  # Validations
  validates_presence_of :image
end
