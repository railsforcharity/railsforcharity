require "spec_helper"

describe Emailer do
  let(:user) { build(:user) }
  let(:project) { build(:project) }
  let(:task) { build(:task, project: project, creator: user) }

  describe 'new_task email' do
    let(:mail) { Emailer.send_task_email(user, :new_task, project, task) }
    subject { mail }
    it { should deliver_to user.email }
    it { should deliver_from 'donotreply@railsforcharity.org' }
    it { should have_subject "[RailsforCharity] (#{project.name}) New task" }
    it { should have_body_text "A new task has been created." }
  end

  describe 'task_assigned email' do
    before :each do
      task.assignee = user
      task.status = Task::STATUSES[:ongoing]
    end

    let(:mail) { Emailer.send_task_email(user, :task_assigned, project, task) }
    subject { mail }
    it { should deliver_to user.email }
    it { should have_subject "[RailsforCharity] (#{project.name}) Task assigned" }
    #it { should have_body_text "Dear someone@someco.com," }
  end

  describe 'task_unassigned email' do
    let(:mail) { Emailer.send_task_email(user, :task_unassigned, project, task) }
    subject { mail }
    it { should deliver_to user.email }
    it { should have_subject "[RailsforCharity] (#{project.name}) Task unassigned" }
    #it { should have_body_text "Dear someone@someco.com," }
  end

  describe 'task_delivered email' do
    before :each do
      task.assignee = user
    end
    let(:mail) { Emailer.send_task_email(user, :task_delivered, project, task) }
    subject { mail }
    it { should deliver_to user.email }
    it { should have_subject "[RailsforCharity] (#{project.name}) Task delivered" }
    #it { should have_body_text "Dear someone@someco.com," }
  end

  describe 'task_accepted email' do
    let(:mail) { Emailer.send_task_email(user, :task_accepted, project, task) }
    subject { mail }
    it { should deliver_to user.email }
    it { should have_subject "[RailsforCharity] (#{project.name}) Task accepted" }
    #it { should have_body_text "Dear someone@someco.com," }
  end
end
