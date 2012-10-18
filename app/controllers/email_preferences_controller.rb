class EmailPreferencesController < ApplicationController
  # GET /email_preferences
  # GET /email_preferences.json
  def index
    @email_preferences = EmailPreference.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @email_preferences }
    end
  end

  # GET /email_preferences/1
  # GET /email_preferences/1.json
  def show
    @email_preference = EmailPreference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @email_preference }
    end
  end

  # GET /email_preferences/new
  # GET /email_preferences/new.json
  def new
    @email_preference = EmailPreference.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @email_preference }
    end
  end

  # GET /email_preferences/1/edit
  def edit
    @email_preference = EmailPreference.find(params[:id])
  end

  # POST /email_preferences
  # POST /email_preferences.json
  def create
    @email_preference = EmailPreference.new(params[:email_preference])

    respond_to do |format|
      if @email_preference.save
        format.html { redirect_to @email_preference, notice: 'Email preference was successfully created.' }
        format.json { render json: @email_preference, status: :created, location: @email_preference }
      else
        format.html { render action: "new" }
        format.json { render json: @email_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /email_preferences/1
  # PUT /email_preferences/1.json
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

  # DELETE /email_preferences/1
  # DELETE /email_preferences/1.json
  def destroy
    @email_preference = EmailPreference.find(params[:id])
    @email_preference.destroy

    respond_to do |format|
      format.html { redirect_to email_preferences_url }
      format.json { head :no_content }
    end
  end
end
