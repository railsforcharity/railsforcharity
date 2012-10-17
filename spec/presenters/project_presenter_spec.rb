require 'spec_helper'

describe ProjectPresenter do
  include Devise::TestHelpers

  let(:project) { create(:project) }

  def login_user(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe '#is_member?' do
    let(:project_presenter) { ProjectPresenter.new(project, view) }

    it 'returns nil if user is not logged in' do
      project_presenter.is_member?.should be_nil
    end

    describe 'user is logged in' do
      before :each do
        @user = create(:user)
      end

      it 'returns false if the user is not a collaborator of that project' do
        project_presenter.is_member?.should be_false
      end

      it 'returns true if the user is a collaborator of that project' do
        create(:user_permission, user: @user, entity: project, role_id: Role::TYPES[:project_collaborator])
        login_user(@user)

        project_presenter.is_member?.should be_true
      end
    end
  end
end
