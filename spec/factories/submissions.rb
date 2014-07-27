# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submission do
    sub_title {Faker::Company.name}
    sub_content {Faker::Lorem.sentence}
    status "draft"
    assignment_id 1
    user_id 1
  end
end

