class Authentication < ActiveRecord::Base

  attr_accessible :provider, :uid

  # Relations
  belongs_to :user

end
