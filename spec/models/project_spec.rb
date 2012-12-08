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
      it 'makes creator the project admin' do
        project.is_admin?(project.creator).should be_true
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
      p = create(:project, :category_names => 'abc, cde')
      p.tags.size.should == 2
    end

    it 'assigns technology tags' do
      p = create(:project, :technology_names => 'ruby, javascript')
      p.technologies.size.should == 2
    end
  end

  describe 'methods' do
    describe '#get_role' do
      it 'gets the role of the user for the project' do
        u1 = create(:user)
        u2 = create(:user)
        u3 = create(:user)
        c1 = UserPermission.create(user: u1, entity: project, role_id: Role::TYPES[:project_collaborator])
        c2 = UserPermission.create(user: u2, entity: project, role_id: Role::TYPES[:project_admin])
        c3 = UserPermission.create(user: u3, entity: project, role_id: Role::TYPES[:project_collaborator])
        project.get_role(u1).should_not be_nil
        project.get_role(u1).should == Role::TYPES[:project_collaborator]
        project.get_role(u2).should_not be_nil
        project.is_admin?(u2).should be_true
      end
    end

    describe '#make_admin(user)' do
      context 'for existing collaborator' do
        it 'makes the user an admin of the project' do
          project.make_collaborator(user)
          project.make_admin(user)
          project.is_admin?(user).should be_true
        end
      end

      context 'for non-existing collaborator' do
        it 'makes the user an admin of the project' do
          project.make_admin(user)
          project.is_admin?(user).should be_true
        end
      end
    end

    describe '#make_collaborator(user)' do
      context 'for existing collaborator' do
        it 'makes the user a collaborator of the project' do
          project.make_admin(user)
          project.make_collaborator(user)
          project.is_collaborator?(user).should be_true
        end
      end

      context 'for non-existing collaborator' do
        it 'makes the user a collaborator of the project' do
          project.make_collaborator(user)
          project.is_collaborator?(user).should be_true
        end
      end
    end

    describe '#hours_worked' do
      it 'returns numbers of hours worked' do
        task1 = create(:task, estimated_hours: 9, estimated_minutes: 30)
        task2 = create(:task, estimated_minutes: 15)
        [task1, task2].map { |t| t.status = Task::STATUSES[:done]  }
        project.tasks = [task1, task2]
        project.hours_worked.should == 9.75
      end
    end

    describe '#join' do
      it 'makes the user a collaborator' do
        project.join(user)
        user.is_collaborator?(project).should be_true
      end

      it 'makes a permissions object for the user for the project' do
        project.join(user)
        project.user_permissions_obj(user).should_not be_nil
      end

      it 'makes a preference object for the user for the project' do
        project.join(user)
        project.user_preferences_obj(user).should_not be_nil
      end
    end

    describe '#unjoin' do
      before(:each) do
        project.join(user)
      end

      it "destroys the user's permissions for the project" do
        project.unjoin(user)
        project.user_permissions_obj(user).should be_nil
      end

      it "destroys the user's preferences for the project" do
        project.unjoin(user)
        project.user_preferences_obj(user).should be_nil
      end
    end
  end
end
