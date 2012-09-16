require File.dirname(File.expand_path(__FILE__)) + "/../../config/environment"

project_tags = ['Education', 'Raising Funds', 'Feeding Homeless People', 'Health Care', 'Agricultural Production',
                'Sustainable Construction', 'Citizen Activism', 'Empowerment', 'Childhood Education',
                'Affordable Transportation', 'Community Solidarity', 'Efficacy', 'Orphanage', 'Old Age Homes']

task_tags = ['ruby', 'java', 'javascript', 'jquery', 'css', 'node.js', 'sass', 'coffeescript', 'ruby on rails',
             'deployment', 'management', 'marketing', 'legal', 'design', 'sales', 'art', 'analytics', 'operations', 'maintenance']

project_tags.each do |tag_name|
  p "Creating #{tag_name}"
  Tag.create(:name => tag_name, :tag_type => 'project')
end

task_tags.each do |tag_name|
  p "creating #{tag_name}"
  Tag.create(name: tag_name, tag_type: 'task')
end