# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    address_line1 "MyString"
    address_line2 "MyString"
    city "MyString"
    state "MyString"
    postal "MyString"
    country "MyString"
    locatable_type "MyString"
    locatable_id 1
  end
end
