# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assignment do
    title "Summer Summary"
    content "In ten paragraphs share the most exciting thing that you did over the summer."
    due_date "11-01-2014"
    classroom_id 42
  end

  factory :assignment_bad_params, class: Assignment do
    title "Summer Summary"
    content "In ten paragraphs share the most exciting thing that you did over the summer."
    due_date "11-01-2014"
  end
end
