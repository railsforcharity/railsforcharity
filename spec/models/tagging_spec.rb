# == Schema Information
#
# Table name: taggings
#
#  id            :integer          not null, primary key
#  taggable_id   :integer
#  taggable_type :string(255)
#  tag_id        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Tagging do
  it "assigns one tag" do
    tag = create(:tag)
    project = create(:project)

    project.tags << tag

    tagging = Tagging.find_by_taggable_type_and_taggable_id('Project', project.id)
    tagging.should_not be_nil
    tagging.tag_id.should == tag.id
  end
end
