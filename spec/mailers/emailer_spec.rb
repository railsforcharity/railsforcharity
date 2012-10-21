require "spec_helper"

describe Emailer do
  let(:users) { [build(:user)] }
  let(:project) { build(:project) }

  describe 'new_task email' do
    let(:mail) { Emailer.send_email(users, :new_task, project) }
    subject { mail }
    it { should deliver_to users.map(&:email).join(",") }
    it { should deliver_from 'donotreply@railsforcharity.org' }
    it { should have_subject "[RailsforCharity] (#{project.name}) New task created" }
    it { should have_body_text "A new task has been created." }
  end

  describe 'task_assigned email' do
    let(:mail) { Emailer.send_email(users, :task_assigned, project) }
    subject { mail }
    it { should deliver_to users.map(&:email).join(",") }
    it { should have_subject "[RailsforCharity] (#{project.name}) task assigned" }
    #it { should have_body_text "Dear someone@someco.com," }
  end

  describe 'task_unassigned email' do
    let(:mail) { Emailer.send_email(users, :task_unassigned, project) }
    subject { mail }
    it { should deliver_to users.map(&:email).join(",") }
    it { should have_subject "[RailsforCharity] (#{project.name}) task unassigned" }
    #it { should have_body_text "Dear someone@someco.com," }
  end

  describe 'task_delivered email' do
    let(:mail) { Emailer.send_email(users, :task_delivered, project) }
    subject { mail }
    it { should deliver_to users.map(&:email).join(",") }
    it { should have_subject "[RailsforCharity] (#{project.name}) task delivered" }
    #it { should have_body_text "Dear someone@someco.com," }
  end

  describe 'task_accepted email' do
    let(:mail) { Emailer.send_email(users, :task_accepted, project) }
    subject { mail }
    it { should deliver_to users.map(&:email).join(",") }
    it { should have_subject "[RailsforCharity] (#{project.name}) task accepted" }
    #it { should have_body_text "Dear someone@someco.com," }
  end

  #describe 'task_rejected email' do
  #  let(:mail) { Emailer.send_email(users, :task_rejected, project) }
  #  subject { mail }
  #  it { should deliver_to users.map(&:email).join(",") }
  #  it { should have_subject "[RailsforCharity] (#{project.name}) task rejected" }
  #  #it { should have_body_text "Dear someone@someco.com," }
  #end
end
