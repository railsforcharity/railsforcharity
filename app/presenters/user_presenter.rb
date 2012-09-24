class UserPresenter < ApplicationPresenter
  presents :user

  def avatar
    img = 'default.png'
    img = user.avatar.image_url(:thumb).to_s if user.avatar
    h.image_tag img, :height => '80', :width => '80'
  end
end
