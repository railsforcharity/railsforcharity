# == Schema Information
#
# Table name: project_accesses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string(255)
#  role_id    :integer
#

require 'spec_helper'

describe ProjectAccess do

  subject { build(:project_access) }

  describe 'validations' do
    context 'for user' do
      it { should allow_mass_assignment_of(:user_id) }
      it { should validate_presence_of(:user_id) }
    end

    context 'for project' do
      it { should allow_mass_assignment_of(:project_id) }
      it { should validate_presence_of(:project_id) }
    end

    context 'for role' do
      it { should allow_mass_assignment_of(:role_id) }
    end
  end

end
