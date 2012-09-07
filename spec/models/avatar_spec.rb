# == Schema Information
#
# Table name: avatars
#
#  id              :integer          not null, primary key
#  avatarable_type :string(255)
#  avatarable_id   :integer
#  image           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe Avatar do
  pending "add some examples to (or delete) #{__FILE__}"
end
