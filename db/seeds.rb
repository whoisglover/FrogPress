# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Default Database Strategy
# DatabaseCleaner.strategy = :truncation  - moved to Rspec Config

test_submissions = []
10.times do
  FactoryGirl.create(:classroom)
  FactoryGirl.create(:student)
  FactoryGirl.create(:teacher)
  FactoryGirl.create(:assignment)
  FactoryGirl.create(:submission)
end
teacher = FactoryGirl.create(:teacher)
User.first.submissions << Submission.all

Assignment.all[0].submissions << Submission.all
# Assignment.all[1].submissions << Submission.all[5..9]

paper_one = Assignment.all[0]
paper_two = Assignment.all[1]

Classroom.all[0].assignments << paper_one
Classroom.all[1].assignments << paper_two

teacher.classrooms << Classroom.all[0]
User.first.classrooms << Classroom.all
