require File.dirname(File.expand_path(__FILE__)) + "/../../config/environment"

project_tags = ['Education', 'Raising Funds', 'Feeding Homeless People', 'Health Care', 'Agricultural Production', 'Sustainable Construction', 'Citizen Activism', 'Empowerment', 'Childhood Education', 'Affordable Transportation', 'Community Solidarity', 'Efficacy']
task_tags = ['Ruby', 'Java', 'Javascript', 'Jquery', 'CSS', 'Node.js', 'SASS', 'Coffeescript', 'Ruby on Rails', 'Deployment', 'Management', 'Marketing', 'Legal', 'Design', 'Sales', 'Art', 'Analytics', 'Operations', 'Maintenance']
other_tags = ['Management', 'Marketing', 'Legal', 'Design', 'Sales', 'Art', 'Analytics', 'Operations', 'Maintenance']

project_tags.each do |tag_name|
  p "Creating #{tag_name}"
  Tag.create(:name => tag_name, :tag_type => 'project')
end

task_tags.each do |tag_name|
  p "creating #{tag_name}"
  Tag.create(name: tag_name, tag_type: 'task')
end