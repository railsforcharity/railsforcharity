class UserPresenter < ApplicationPresenter
  presents :user

  def avatar(size)
    img = 'default.png'
    img = user.avatar.image_url(:thumb).to_s if user.avatar
    h.image_tag img, :height => size, :width => size
  end
end
