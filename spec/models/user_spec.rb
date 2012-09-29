# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  bio                    :text
#  website                :string(255)
#  slug                   :string(255)
#

require 'spec_helper'

describe User do

  describe '#is_collaborator?' do
    before :each do
      @user1 = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
      @project = create(:project)
      @project.users = [@user1, @user2]
    end

    it "returns true if collaborator?" do
      @user1.is_collaborator?(@project).should be_true
    end

    it "returns false if not a collaborator?" do
      @user3.is_collaborator?(@project).should be_false
    end
  end
end
