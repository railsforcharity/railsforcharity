# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  title       :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#

require 'spec_helper'

describe Project do
  describe 'associations' do

  end

  describe 'validations' do
    it { should allow_mass_assignment_of(:name) }
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_least(3).is_at_most(25) }
    #it { should validate_uniqueness_of(:name) }

    it { should allow_mass_assignment_of(:title) }
    it { should validate_presence_of(:title) }
    it { should ensure_length_of(:title).is_at_least(10).is_at_most(140) }

    it { should allow_mass_assignment_of(:description) }
    it { should validate_presence_of(:description) }
    it { should ensure_length_of(:description).is_at_least(50).is_at_most(2000) }
  end
end
