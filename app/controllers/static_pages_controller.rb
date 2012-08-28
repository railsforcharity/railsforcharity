class StaticPagesController < ApplicationController

  def contact
    @contact_us = ContactUs.new(:id => 1)
  end

  def contact_us_create
    @contact_us = ContactUs.new(params[:contact_us])
    if @contact_us.save
      flash[:notice] = "Thanks for getting in touch! You will receive a response from us within 24 hours. Have a wonderful day ahead!"
      redirect_to :back
    else
      flash[:error] = "Could not send email."
      render 'contact'
    end
  end

end