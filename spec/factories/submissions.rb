# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submission do
    sub_title {Faker::Company.name}
    sub_content {Faker::Lorem.sentence}
    status "draft"
  end
end

