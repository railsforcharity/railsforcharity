class AvatarsController < ApplicationController

  def update
    if current_user.update_attributes(params[:user])
      current_user.avatar.update_attributes(:crop_x => params[:crop_x])
      require 'pp'
      pp params
      respond_to do |format|
        format.html { redirect_to current_user, notice: t('controllers.users.update.success') }
        format.json { head :no_content }
        image.crop_avatar if current_user.avatar.cropping?
      end
    else
      respond_to do |format|
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
end
