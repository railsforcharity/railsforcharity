module CommentsHelper
  def nested_comments(comments)
    comments.map do |comment, sub_comments|
      render(comment) + content_tag(:div, nested_comments(sub_comments), :class => "nested_comments")
    end.join.html_safe
  end

  def can_edit?(comment)
    #User.find(comment.created_by) == current_user
  end
end
