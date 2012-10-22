# == Schema Information
#
# Table name: email_preferences
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  email_type  :integer
#  entity_id   :integer
#  entity_type :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe EmailPreference do
  pending "add some examples to (or delete) #{__FILE__}"
end
