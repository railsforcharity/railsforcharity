class StaticPagesController < ApplicationController

  def home
    render :layout => 'home'
  end

  def contact
    @contact_us = ContactUs.new(:id => 1)
  end

  def contact_us
    @contact_us = ContactUs.new(params[:contact_us])
    if @contact_us.save
      flash[:notice] = t('controllers.static_pages.contact_us.success')
      redirect_to :back
    else
      flash[:error] = t('controllers.static_pages.contact_us.failure')
      render 'contact'
    end
  end

  def preview
    render partial: 'preview'
  end
end