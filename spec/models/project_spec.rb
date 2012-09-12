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
#  website     :string(255)
#  profile_url :string(255)
#  status      :string(255)
#  video       :string(255)
#

require 'spec_helper'

describe Project do
  describe 'associations' do

  end

  describe 'validations' do
    subject { create(:project) }
    it { should allow_mass_assignment_of(:name) }
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_least(2).is_at_most(25) }
    it { should validate_uniqueness_of(:name) }

    it { should allow_mass_assignment_of(:title) }
    it { should validate_presence_of(:title) }
    it { should ensure_length_of(:title).is_at_least(10).is_at_most(140) }

    it { should allow_mass_assignment_of(:description) }
    it { should validate_presence_of(:description) }
    it { should ensure_length_of(:description).is_at_least(50).is_at_most(2000) }

    it { should allow_mass_assignment_of(:website) }
    it { should ensure_length_of(:website).is_at_most(500) }

    it { should allow_mass_assignment_of(:profile_url) }
    it { should validate_presence_of(:profile_url) }
    it { should ensure_length_of(:profile_url).is_at_least(2).is_at_most(25) }
    it { should validate_uniqueness_of(:profile_url) }

    it { should allow_mass_assignment_of(:video) }
    it { should ensure_length_of(:video).is_at_most(500) }

    it { should allow_mass_assignment_of(:collaborator_tokens) }
    it { should allow_mass_assignment_of(:avatar_attributes) }

    it { should allow_mass_assignment_of(:terms) }
    # it { should validate_acceptance_of(:terms) }  Waiting for https://github.com/thoughtbot/shoulda-matchers/issues/131
  end

  describe 'behaviour' do
    before :each do
      @project = create(:project)
      @user1 = create(:user)
      @user2 = create(:user)
    end

    it 'saves collaborators for a project' do
      h = {}
      h["collaborator_tokens"] = [@user1.id, @user2.id].join(",")
      @project.update_attributes(h)
      @project.users.size.should == 2
    end
  end

  describe 'tagging' do
    it 'assigns tags' do
      p = create(:project, :tag_names => 'abc, cde')
      p.tags.size.should == 2
    end
  end

end
