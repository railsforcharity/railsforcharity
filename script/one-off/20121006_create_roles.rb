require File.dirname(File.expand_path(__FILE__)) + "/../../config/environment"

roles = {
  project_admin: 'Administrator of a given project',
  project_collaborator: 'Collaborator of a given project'
}

roles.each do |role, description|
  p "Creating role: #{role}"
  Role.create(:name => role, :description => description)
end