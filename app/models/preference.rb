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

class Preference < ActiveRecord::Base
  serialize :properties, ActiveRecord::Coders::Hstore # http://stackoverflow.com/a/11074481/238880

  attr_accessible :user, :entity, :entity_id, :entity_type, :user_id, :properties

  # Relations
  belongs_to :user
  belongs_to :entity, polymorphic: true

  # Accessor Methods

  EmailTemplate::TYPES.each do |name, _|
    attr_accessible name
    scope "has_#{name}", lambda { where("properties @> (? => ?)", name, "1") }

    define_singleton_method "#{name}_users" do
      (self.send "has_#{name}").map(&:user)
    end

    define_method name do
      properties && properties[name]
    end

    define_method "#{name}=" do |value|
      self.properties = (properties || {}).merge(name => value)
    end
  end
end
