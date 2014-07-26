# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submission do
    sub_title "My Summer at DevBootcamp"
    sub_content "I made so many friends at DBC.  I was nervous because I am a bit shy"
    status "draft"
  end
end

