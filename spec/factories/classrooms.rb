# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :classroom do
    name "Period 1"
    grade_level 5
    join_code "hello"
  end
end
