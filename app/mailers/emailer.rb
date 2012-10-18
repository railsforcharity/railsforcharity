require 'erb'

class Emailer < ActionMailer::Base

  default :from => "donotreply@railsforcharity.org"

  def contact_us(sender)
    @sender = sender

    mail(
      :to => ENV['MAIL_USERNAME'],
      :from => @sender.email,
      :subject => "[RailsforCharity]: Email from " + @sender.name
    )
  end

  def send_email(user, email_type, entity)
    subject_template = ERB.new(EmailTemplate::TYPES[email_type][:subject])
    subject = subject_template.result(binding)

    mail(
      :to => user.email,
      :subject => "[RailsforCharity]: #{subject}"
    )
  end

end
