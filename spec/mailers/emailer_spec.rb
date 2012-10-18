require "spec_helper"

describe Emailer do
  let(:user) { build(:user) }
  let(:project) { build(:project) }

  describe 'new_task email' do
    let(:mail) { Emailer.send_email(user, :new_task, project) }

    it 'renders the sender email' do
      mail.from.should == ['donotreply@railsforcharity.org']
    end

    it 'renders the receiver email' do
      mail.to.should == [user.email]
    end

    it 'renders the project name in the subject' do
      mail.subject.should match project.name
    end
  end
end
