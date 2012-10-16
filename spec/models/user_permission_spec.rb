# == Schema Information
#
# Table name: user_permissions
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :string(255)
#  role_id     :integer
#  entity_type :string(255)
#  entity_id   :integer
#

require 'spec_helper'

describe UserPermission do

  subject { build(:user_permission) }

  describe 'validations' do
    context 'for user' do
      it { should allow_mass_assignment_of(:user_id) }
      it { should validate_presence_of(:user_id) }
    end

    context 'for project' do
      it { should allow_mass_assignment_of(:entity_id) }
      it { should validate_presence_of(:entity_id) }
    end

    context 'for role' do
      it { should allow_mass_assignment_of(:role_id) }
    end
  end

end
