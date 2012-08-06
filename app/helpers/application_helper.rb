module ApplicationHelper
  def user_not_signed_in?
    !user_signed_in?
  end
end
