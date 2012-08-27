module ApplicationHelper
  def user_not_signed_in?
    !user_signed_in?
  end

  # Opens the link in a new tab/page
  def link_to_blank(body, url, html_options = {})
    link_to body, url, html_options.merge(:target => '_blank')
  end
  # TODO: need to put all images in the railsforcharity amazonaws server
  # Image Helpers
  def email_image; image_tag 'https://s3-ap-southeast-1.amazonaws.com/tracksgivingstatic/contact/email.png'; end
  def cellphone_image; image_tag 'https://s3-ap-southeast-1.amazonaws.com/tracksgivingstatic/contact/mobile.png' end
  def skype_image; image_tag 'https://s3-ap-southeast-1.amazonaws.com/tracksgivingstatic/contact/skype.png'; end
  def deletex_image; image_tag 'https://s3-ap-southeast-1.amazonaws.com/tracksgivingstatic/contact/deletex.png'; end

end
