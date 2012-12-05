module ApplicationHelper

  def user_not_signed_in?
    !user_signed_in?
  end

  # Opens the link in a new tab/page
  def link_to_blank(name, link_url=name, link_url_html_options = {})
    link_to name, link_url, link_url_html_options.merge(:target => '_blank')
  end

  def link_to_image(image_url, image_html_options = {}, link_url=name, link_url_html_options = {})
    link_to image_tag(image_url, image_html_options.merge(alt: image_html_options[:title])), link_url, link_url_html_options.merge(:target => '_blank')
  end

  def present(object, klass=nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def markdown
    options = { autolink: true, space_after_headers: true, hard_wrap: true, filter_html: true,  no_intraemphasis: true, fenced_code: true, gh_blockcode: true }
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
  end

  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.to_s
  end

end
