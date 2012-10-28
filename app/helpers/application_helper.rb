module ApplicationHelper

  def user_not_signed_in?
    !user_signed_in?
  end

  # Opens the link in a new tab/page
  def link_to_blank(name, url=name, html_options = {})
    link_to name, url, html_options.merge(:target => '_blank')
  end

  def present(object, klass=nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def markdown
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      :autolink => true, :space_after_headers => true, :hard_wrap => true, :filter_html => true,  :no_intraemphasis => true, :fenced_code => true, :gh_blockcode => true)
  end

  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.to_s
  end

end
