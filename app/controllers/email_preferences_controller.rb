class EmailPreferencesController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @email_preferences = current_user.email_preferences
  end

  def update
    @email_preference = EmailPreference.find(params[:id])

    respond_to do |format|
      if @email_preference.update_attributes(params[:email_preference])
        format.html { redirect_to @email_preference, notice: 'Email preference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @email_preference.errors, status: :unprocessable_entity }
      end
    end
  end
end
