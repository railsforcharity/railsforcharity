# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  commentable_id   :integer
#  commentable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  ancestry         :string(255)
#  created_by       :integer
#

class Comment < ActiveRecord::Base
  attr_accessible :content, :parent_id, :created_by

  belongs_to :commentable, polymorphic: true

  has_ancestry

  # Validations
  validates :content, :presence => true
end
