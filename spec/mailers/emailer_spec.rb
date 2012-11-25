require "spec_helper"

describe Emailer do
  let(:creator) { create(:user) }
  let(:assignee) { create(:user) }
  let(:project) { create(:project) }
  let(:new_task) { create(:task, project: project, creator: creator) }
  let(:task) { create(:task, project: project, creator: creator, assignee: assignee) }

  describe 'new_task email' do
    let(:mail) { Emailer.send_task_email(creator.id, "new_task", new_task.id) }
    subject { mail }
    it { should deliver_to creator.email }
    it { should deliver_from 'donotreply@railsforcharity.org' }
    it { should have_subject "[RailsforCharity] (#{project.name}) New task" }
    it { should have_body_text "A new task has been created." }
  end

  describe 'task_assigned email' do
    before :each do
      task.status = Task::STATUSES[:ongoing]
    end

    let(:mail) { Emailer.send_task_email(creator.id, "task_assigned", task.id) }
    subject { mail }
    it { should deliver_to creator.email }
    it { should have_subject "[RailsforCharity] (#{project.name}) Task assigned" }
    #it { should have_body_text "Dear someone@someco.com," }
  end

  describe 'task_unassigned email' do
    let(:mail) { Emailer.send_task_email(creator.id, "task_unassigned", task.id) }
    subject { mail }
    it { should deliver_to creator.email }
    it { should have_subject "[RailsforCharity] (#{project.name}) Task unassigned" }
    #it { should have_body_text "Dear someone@someco.com," }
  end

  describe 'task_delivered email' do
    before :each do
    end
    let(:mail) { Emailer.send_task_email(creator.id, "task_delivered", task.id) }
    subject { mail }
    it {
      should deliver_to creator.email
    }
    it { should have_subject "[RailsforCharity] (#{project.name}) Task delivered" }
    #it { should have_body_text "Dear someone@someco.com," }
  end

  describe 'task_accepted email' do
    let(:mail) { Emailer.send_task_email(assignee.id, "task_accepted", task.id) }
    subject { mail }
    it { should deliver_to assignee.email }
    it { should have_subject "[RailsforCharity] (#{project.name}) Task accepted" }
    #it { should have_body_text "Dear someone@someco.com," }
  end
end
