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

  def send_task_email(recipient_id, email_type, task_id)
    @task = Task.find(task_id)
    project = @task.project
    @user = User.find(recipient_id)
    subject_template = ERB.new(EmailTemplate::TYPES[email_type.to_sym][:subject])
    subject = subject_template.result(binding)
    mail(:to => @user.email, :subject => "[RailsforCharity] #{subject}") do |format|
      format.html { render "emailer/email_templates/#{email_type}" }
    end.deliver
  end

end
