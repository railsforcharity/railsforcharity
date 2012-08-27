class Emails < ActionMailer::Base
  
  def contact_us(sender)
    @sender = sender
    mail(:to => ENV['MAIL_USERNAME'],
	 :from => sender.email, 
	 :subject => "[RailsforCharity]: Email from " + @sender.name)
  end
  
end
