# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student, class: User do
    first_name {Faker::Name.first_name} #=> "Kaci"
    last_name {Faker::Name.last_name} #=> "Kaci"
    email {Faker::Internet.email}
    user_type "student"
    password "abcdefgh"
  end

  factory :teacher, class: User do
    first_name {Faker::Name.first_name} #=> "Kaci"
    last_name {Faker::Name.last_name} #=> "Kaci"
    email {Faker::Internet.email}
    user_type "teacher"
    password "abcdefgh"
  end
end


