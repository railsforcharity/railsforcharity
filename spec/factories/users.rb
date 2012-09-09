# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker.name }
    email { Faker::Internet.email }
    password 'secret'
    password_confirmation 'secret'
    confirmed_at { Time.now }
  end
end
