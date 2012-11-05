# == Schema Information
#
# Table name: tasks
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  description    :text
#  task_type      :string(255)
#  status         :integer
#  estimated_time :integer
#  project_id     :integer
#  created_by     :integer
#  assigned_to    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category       :integer
#

require 'spec_helper'

describe Task do

  # subject { create(:task) }
  # Subject blocks allow you to control the initialization of the subject under test.
  # If you don't have any custom initialization required, then you're given a default `subject` method already.
  # All it does is call `new` on the class you're testing.

  # let(:task) { task }
  # Let blocks allow you to provide some input to the subject block that change in various contexts.
  # This way you can simply provide an alternative `let` block for a given value and not have to duplicate the setup code for the subject over again.
  # Let blocks also work inside of `before :each` blocks if you need them.
  # https://www.relishapp.com/rspec/rspec-core/docs/helper-methods/let-and-let

  # Its blocks allow you to test methods on the subject that return a simple value.
  # The benefit of using this over the more wordy version above is that it can actually format the test output for you.

  describe 'validations' do
    context 'for name' do
      it { should allow_mass_assignment_of(:name) }
      it { should validate_presence_of(:name) }
      it { should ensure_length_of(:name).is_at_least(2).is_at_most(255) }
    end

    context 'for description' do
      it { should allow_mass_assignment_of(:description) }
      it { should validate_presence_of(:description) }
      it { should ensure_length_of(:description).is_at_least(20) }
    end

    context 'for category' do
      it { should allow_mass_assignment_of(:category) }
      it { should validate_presence_of(:category) }
    end

    context 'for project' do
      it { should allow_mass_assignment_of(:project_id) }
      it { should validate_presence_of(:project_id) }
    end

    context 'for task type' do
      it { should allow_mass_assignment_of(:task_type) }

      context 'when category is programming' do
        subject { create(:task, :category => Task::CATEGORIES[:programming]) }
        it { should validate_presence_of(:task_type) }
      end

      context 'when category is not programming' do
        subject { create(:task, :category => Task::CATEGORIES[:management]) }
        it { should_not validate_presence_of(:task_type) }
      end
    end

    context 'for estimated hours' do
      it { should allow_mass_assignment_of(:estimated_hours) }
    end

    context 'for estimated minutes' do
      it { should allow_mass_assignment_of(:estimated_minutes) }
    end

    context 'for status' do
      it { should_not allow_mass_assignment_of(:status) }
    end
  end

  describe 'for setting estimated time' do
    let(:task) { create(:task, estimated_minutes: 560) }

    context 'setting estimated time' do
      it 'should set estimated_time after update' do
        task.update_attributes(estimated_hours: 5, estimated_minutes: 45)
        task.estimated_hours.should == 5
      end

      it 'should set same estimated time on change of task\'s status' do
        task.status = Task::STATUSES[:done]
        p task.status
        task.estimated_hours.should == 9
      end
    end
  end
end

# subject { create(:task, :category => Task::CATEGORIES[:management]) }
# let(:category) { Task::CATEGORIES[:management] }
