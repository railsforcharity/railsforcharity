# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_permission do
    user_id 1
    entity_id 1
    entity_type 'Project'
  end
end
