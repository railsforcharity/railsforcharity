require 'spec_helper'

describe ApplicationHelper do
  include Devise::TestHelpers

  def login_user(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe '#is_collaborator?' do
    before(:each) do
      @project = create(:project)
    end

    it 'returns nil if user is not logged in' do
      helper.is_collaborator?(@project).should be_nil
    end

    describe 'user is logged in' do
      before :each do
        @user = create(:user)
      end

      it 'returns false if the user is not a collaborator of that project' do
        helper.is_collaborator?(@project).should be_false
      end

      it 'returns true if the user is a collaborator of that project' do
        @project.users << @user
        login_user(@user)

        helper.is_collaborator?(@project).should be_true
      end
    end
  end
end
