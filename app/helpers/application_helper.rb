module ApplicationHelper

  def user_not_signed_in?
    !user_signed_in?
  end

  # Opens the link in a new tab/page
  def link_to_blank(body, url=body, html_options = {})
    link_to body, url, html_options.merge(:target => '_blank')
  end

  def present(object, klass=nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def x(n, singular, plural=nil)
      if n == 1
          "1 #{singular}"
      elsif plural
          "#{n} #{plural}"
      else
          "#{n} #{singular}s"
      end
  end

end
