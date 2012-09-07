# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :avatar do
    avatarable_type "MyString"
    avatarable_id 1
    image "MyString"
    remote_image_url "MyString"
  end
end
