require 'erb'

class Emailer < ActionMailer::Base

  default :from => "donotreply@railsforcharity.org"
  layout 'email'

  def contact_us(sender)
    @sender = sender

    mail(
      :to => ENV['MAIL_USERNAME'],
      :from => @sender.email,
      :subject => "[RailsforCharity]: Email from " + @sender.name
    )
  end

  def send_email(recipients, email_type, entity)
    subject_template = ERB.new(EmailTemplate::TYPES[email_type][:subject])
    subject = subject_template.result(binding)
    @user = recipients.first

    mail(
      :to => recipients.map(&:email).join(","),
      :subject => "[RailsforCharity] #{subject}"
    ) do |format|
      format.html { render "emailer/email_templates/#{email_type}" }
    end
  end

end
