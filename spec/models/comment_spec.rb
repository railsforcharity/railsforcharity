# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  commentable_id   :integer
#  commentable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  ancestry         :string(255)
#  created_by       :integer
#

require 'spec_helper'

describe Comment do

  describe 'validations' do
    subject { create(:comment) }
    it { should allow_mass_assignment_of(:content) }
    it { should validate_presence_of(:content) }
  end
end
