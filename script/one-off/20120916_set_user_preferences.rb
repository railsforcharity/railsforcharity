require File.dirname(File.expand_path(__FILE__)) + "/../../config/environment"

users = User.all

users.each do |user|
  user.projects.each do |user_project|
    preference = Preference.find_or_create_by_entity_type_and_entity_id_and_user_id('Project', user_project.id, user.id)
    preference.properties = (preference.properties || {}).merge("new_task" => "1")
    puts "Saving preferences for User #{user.id}:#{user.slug} & Project #{user_project.id}:#{user_project.name}"
    preference.save
  end
end
