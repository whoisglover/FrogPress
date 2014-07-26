# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :classroom do
    name {Faker::Company.name}
    grade_level {Faker::Number.digit}
    join_code {Faker::Name.last_name}
  end
  factory :invalid_classroom, class: Classroom do
    name "Timmy Tisdale"
    join_code "hello"
  end
end
