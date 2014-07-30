# Read about factories at https://github.com/thoughtbot/factory_girl

  # @fake_date Date.today + rand(9)
FactoryGirl.define do
  factory :assignment do
    title {Faker::Company.catch_phrase}
    content {Faker::Lorem.sentence}
    # due_date  {Faker::Business.credit_card_expiry_date}
    due_date {Date.today + Faker::Number.digit.to_i}
    association :classroom
  end

  factory :assignment_bad_params, class: Assignment do
    title "Summer Summary"
    content "In ten paragraphs share the most exciting thing that you did over the summer."
    due_date "11-01-2014"
  end
end

