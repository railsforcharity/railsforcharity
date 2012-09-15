# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    name { words(2) }
    description { words(40) }
    task_type { ['chore', 'feature', 'bug', 'release'].sample }
    status "MyString"
    hours 4
    project_id 1
  end
end
