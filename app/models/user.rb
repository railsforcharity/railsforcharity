class User < ActiveRecord::Base
  # Devise modules. Others available are: :token_authenticatable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  # Relations
  has_many :authentications

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
end
