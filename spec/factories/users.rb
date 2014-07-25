# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student, class: User do
    first_name "Mario"
    last_name "Bros"
    email "mario@example.com"
    user_type "student"
    password "abcdefgh"

  end

  factory :teacher, class: User do
    first_name "Bowser"
    last_name "Bros"
    email "bowser@example.com"
    user_type "teacher"
    password "abcdefgh"
  end
end


