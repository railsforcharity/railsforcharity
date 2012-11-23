require 'erb'

class Emailer < ActionMailer::Base

  default :from => "donotreply@railsforcharity.org"
  layout 'email/email', except: [:contact_us]

  def contact_us(sender)
    @sender = sender

    mail(
      :to => ENV['MAIL_USERNAME'],
      :from => @sender.email,
      :subject => "[RailsforCharity]: Email from " + @sender.name
    )
  end

  def send_task_email(recipient, email_type, task)
    subject_template = ERB.new(EmailTemplate::TYPES[email_type][:subject])
    project = task.project
    subject = subject_template.result(binding)
    @task = task
    @user = recipient
    mail(:to => @user.email, :subject => "[RailsforCharity] #{subject}") do |format|
      format.html { render "emailer/email_templates/#{email_type}" }
    end
  end
end
