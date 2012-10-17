class ProjectPresenter < ApplicationPresenter
  presents :project
  delegate :name, :title, :status, :video, :description, :to_param, :created_by,
           :categories, :technologies, :tasks, :users, :reputation_value_for, to: :project

  def website
    w = project.website
    if !w.blank? && !(w.start_with? 'http')
      w = 'http://' + w
    end

    h.link_to w, w, :target => '_blank'
  end

  def avatar_name
    if project.avatar
      h.image_tag project.avatar.image_url(:thumb).to_s
    else
      h.image_tag "default.png"
    end
  end

  def github_url
    "https://github.com/railsforcharity/" + project.profile_url
  end

  def travis_url
    "http://travis-ci.org/railsforcharity/" + project.profile_url + '.png'
  end

  def can_edit?(project)
    User.find(project.created_by) == current_user
  end

  def collaborators
    if !(project.users.include? h.current_user)
      project.users << h.current_user
    else
      project.users
    end
  end

  def is_member?
    h.current_user && project.users.include?(h.current_user)
  end

  #def method_missing(method_name, *args, &block)
  #  project.send(method_name, *args, &block)
  #end
end
