require "spec_helper"

describe Emailer do
  let(:user) { build(:user) }
  let(:project) { build(:project) }

  describe 'new_task email' do
    let(:mail) { Emailer.send_email(user, :new_task, project) }
    subject { mail }
    it { should deliver_to user.email }
    it { should deliver_from 'donotreply@railsforcharity.org' }
    it { should have_subject "[RailsforCharity] (#{project.name}) New task created" }
    #it { should have_body_text "Dear someone@someco.com," }
  end
end
