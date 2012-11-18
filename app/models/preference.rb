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
    attr_accessible name    # attr_accessible :new_task, :task_assigned, ...

    scope "has_#{name}", lambda { where("properties @> (? => ?)", name, "1") }  # scope :has_new_task, lambda { where("properties @> (? => ?)", :new_task, "1") }

    define_singleton_method "#{name}_users" do                    # def new_task_users
      (self.send "has_#{name}").map(&:user)                       #   self.has_new_task.map(&:user)
    end                                                           # end

    define_method name do                                         # def new_task
      properties && properties[name]                              #   properties && properties[:new_task]
    end                                                           # end

    define_method "#{name}=" do |value|                           # def new_task=
      self.properties = (properties || {}).merge(name => value)   #   self.properties = (properties || {}).merge(:new_task => value)
    end                                                           # end
  end

  def self.user_project_preference(user, project)
    find_by_user_id_and_entity_type_and_entity_id(user.id, 'Project', project.id)
  end
end
