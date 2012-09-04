module ApplicationHelper
  def user_not_signed_in?
    !user_signed_in?
  end

  # Opens the link in a new tab/page
  def link_to_blank(body, url=body, html_options = {})
    link_to body, url, html_options.merge(:target => '_blank')
  end
end
