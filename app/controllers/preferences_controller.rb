class PreferencesController < ApplicationController
  before_filter :authenticate_user!

  def index
    project = params[:project_id] ? Project.find(params[:project_id]) : current_user.projects.first
    @preference = current_user.preferences.where(entity_type: 'Project', entity_id: project).first || Preference.new

    respond_to do |format|
      if request.xhr?
        return render partial: 'settings'
      end
      format.html
    end
  end
end
