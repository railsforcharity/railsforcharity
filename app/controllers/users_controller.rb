class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :find_user, :only => [:edit, :update, :show]

  def edit
    redirect_to edit_user_path(current_user) if current_user != @user
    @user = current_user
  end

  def show
  end

  def index
    @users = User.all(:include => [:avatar])

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to user_path(@user), notice: t('controllers.users.update.success') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def save_preferences
    project = Project.find(params[:project_id])
    preference = project.preferences.where(user_id: current_user.id).first || project.preferences.build(user: current_user)
    preference.properties = params[:preferences].reject{ |key, value| value == "0" }

    if preference.save
      redirect_to user_preferences_path(current_user, project_id: project), notice: t('controllers.users.save_preferences.success')
    else
      redirect_to :back, notice: t('controllers.users.save_preferences.failure')
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

end
