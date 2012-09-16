require File.dirname(File.expand_path(__FILE__)) + "/../../config/environment"

tags = ['Education', 'Raising Funds', 'Feeding Homeless People', 'Health Care', 'Agricultural Production', 'Sustainable Construction', 'Citizen Activism', 'Empowerment', 'Childhood Education', 'Affordable Transportation', 'Community Solidarity', 'Efficacy']

tags.each do |tag_name|
  p "Creating #{tag_name}"
  Tag.create(:name => tag_name, :tag_type => 'project')
end
