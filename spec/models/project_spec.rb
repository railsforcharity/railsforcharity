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

  let(:user) { create(:user) }
  let(:project) { create(:project) }

  subject { project }

  describe 'associations' do

  end

  describe 'validations' do
    it { should allow_mass_assignment_of(:name) }
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_least(2).is_at_most(40) }
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

  describe 'callbacks' do
    describe '#after_create' do
      let(:project) { create(:project, :creator => user) }

      it 'makes creator the project admin' do
        project.is_admin?(user).should be_true
      end
    end

    it 'saves collaborators for a project' do
      project.collaborator_tokens = [user.id, create(:user).id].join(",")
      project.save
      project.users.size.should == 2
    end
  end

  describe 'tagging' do
    it 'assigns tags' do
      p = create(:project, :tag_names => 'abc, cde')
      p.tags.size.should == 2
    end
  end

  describe 'methods' do
    describe '#get_role' do
      it 'gets the role of the user for the project' do
        u1 = create(:user)
        u2 = create(:user)
        u3 = create(:user)
        c1 = ProjectAccess.create(user: u1, project: project, role_id: Role::TYPES[:project_collaborator])
        c2 = ProjectAccess.create(user: u2, project: project, role_id: Role::TYPES[:project_admin])
        c3 = ProjectAccess.create(user: u3, project: project, role_id: Role::TYPES[:project_collaborator])
        project.get_role(u1).should_not be_nil
        project.get_role(u1).should == Role::TYPES[:project_collaborator]
        project.get_role(u2).should_not be_nil
        project.is_admin?(u2).should be_true
      end
    end

    describe '#make_admin(user)' do
      it 'for existing collaborator' do
        project.users << user
        project.make_admin(user)
        project.is_admin?(user).should be_true
      end

      it 'for non-existing collaborator' do
        project.make_admin(user)
        project.is_admin?(user).should be_true
      end
    end

    describe '#make_collaborator(user)' do
      it 'for existing collaborator' do
        project.users << user
        project.make_collaborator(user)
        project.is_collaborator?(user).should be_true
      end

      it 'for non-existing collaborator' do
        project.make_collaborator(user)
        project.is_collaborator?(user).should be_true
      end
    end
  end

end
