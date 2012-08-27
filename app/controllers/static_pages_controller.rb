class StaticPagesController < ApplicationController

  def contact
    @contact_us = ContactUs.new(:id => 1)
  end

  def contact_us_create
    @contact_us = ContactUs.new(params[:contact_us])
    if @contact_us.save
      flash[:notice] = "Email sent successfully."
      render 'contact_us_success'
    else
      flash[:error] = "Could not send email."
      render 'contact'
    end
  end

end