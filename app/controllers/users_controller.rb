class UsersController < ApplicationController
  before_filter :find_user, :only => [:edit, :update, :show]

  def edit
    @user = current_user
  end

  def show
  end

  def index
    @users = User.confirmed_users.name_like(params[:q]).limit(10)

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

  private

  def find_user
    @user = User.find(params[:id])
  end

end
