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
#

require 'spec_helper'

describe Task do

  describe "Validations" do
    subject { create(:task) }

    it { should allow_mass_assignment_of(:name) }
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_least(2).is_at_most(255) }

    it { should allow_mass_assignment_of(:description) }
    it { should validate_presence_of(:description) }
    it { should ensure_length_of(:description).is_at_least(20) }

    it { should allow_mass_assignment_of(:task_type) }
    it { should validate_presence_of(:task_type) }

    it { should allow_mass_assignment_of(:estimated_hours) }
    it { should allow_mass_assignment_of(:estimated_minutes) }

    it { should_not allow_mass_assignment_of(:status) }

  end
end
