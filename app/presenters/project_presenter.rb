class ProjectPresenter < ApplicationPresenter
  presents :project
  delegate :name, :title, :status, :video, :description, :tags, :tasks, :users, :reputation_value_for, to: :project

  def website
    w = project.website
    if !project.website.start_with? 'http'
      w = 'http://' + w
    end

    h.link_to w, w, :target => '_blank'
  end

  def avatar
    h.image_tag project.avatar.image_url(:thumb).to_s if project.avatar
  end

  def github_url
    "https://github.com/railsforcharity/" + self.profile_url
  end

  def travis_url
    "http://travis-ci.org/railsforcharity/" + self.profile_url + '.png'
  end

  def is_collaborator?
    h.current_user && h.current_user.is_collaborator?(project)
  end
end