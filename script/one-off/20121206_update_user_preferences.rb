require File.dirname(File.expand_path(__FILE__)) + "/../../config/environment"

project = Project.find(ENV['PROJECT_ID'])
project.users.each do |user|
  preference = project.user_preferences_obj(user)
  next if preference

  properties = {}
  EmailTemplate::TYPES.map do |property_name, property_details|
    properties[property_name.to_s] = "1"
  end

  Preference.create({
    user: user,
    entity: project,
    properties: properties
  })
end