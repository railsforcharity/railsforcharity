# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#

class Role < ActiveRecord::Base
  attr_accessible :name, :description
end
