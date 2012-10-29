# == Schema Information
#
# Table name: preferences
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  entity_id   :integer
#  entity_type :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  properties  :hstore
#

require 'spec_helper'

describe Preference do
  pending "add some examples to (or delete) #{__FILE__}"
end
