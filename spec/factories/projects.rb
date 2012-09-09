# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name { words(2) }
    title { words(4) }
    description { words(40) }
    profile_url { words(1) }
  end
end
