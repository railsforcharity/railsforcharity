# == Schema Information
#
# Table name: locations
#
#  id             :integer          not null, primary key
#  address_line1  :string(255)
#  address_line2  :string(255)
#  city           :string(255)
#  state          :string(255)
#  postal         :string(255)
#  country        :string(255)
#  locatable_type :string(255)
#  locatable_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Location do
  it { should validate_presence_of :country}
end
