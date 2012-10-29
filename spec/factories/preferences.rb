# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :preference do
    user_id 1
    email_type 1
    entity_id 1
    entity_type "MyString"
  end
end
