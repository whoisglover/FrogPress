# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Default Database Strategy
# DatabaseCleaner.strategy = :truncation  - moved to Rspec Config

# test_submissions = []
# 10.times do
#   FactoryGirl.create(:classroom)
#   FactoryGirl.create(:student)
#   FactoryGirl.create(:teacher)
#   FactoryGirl.create(:assignment)
#   FactoryGirl.create(:submission)
# end
# teacher = FactoryGirl.create(:teacher)
# User.first.submissions << Submission.all

# Assignment.all[0].submissions << Submission.all
# # Assignment.all[1].submissions << Submission.all[5..9]

# paper_one = Assignment.all[0]
# paper_two = Assignment.all[1]

# Classroom.all[0].assignments << paper_one
# Classroom.all[1].assignments << paper_two

# teacher.classrooms << Classroom.all[0]
# User.first.classrooms << Classroom.all

# Teachers
User.create( first_name: "Matthew", last_name: "Kuzio", user_type: "teacher", email: "Matthew@example.com", password: "password")
User.create( first_name: "Danny", last_name: "Glover", user_type: "teacher", email: "Danny@example.com", password: "password")
User.create( first_name: "Amelia", last_name: "Downs", user_type: "teacher", email: "Amelia@example.com", password: "password")
User.create( first_name: "Brennon", last_name: "Williams", user_type: "teacher", email: "Brennon@example.com", password: "password")
User.create( first_name: "Joshua", last_name: "Rosaaen", user_type: "teacher", email: "Joshua@example.com", password: "password")
# Students
User.create( first_name: "Alec", last_name: "Ashford", user_type: "student", email: "alec@example.com", password: "password")
User.create( first_name: "Amol", last_name: "Borcar", user_type: "student", email: "Amol@example.com", password: "password")
User.create( first_name: "Andrew", last_name: "Koines", user_type: "student", email: "Andrew@example.com", password: "password")
User.create( first_name: "Austin", last_name: "Bourdier", user_type: "student", email: "Austin@example.com", password: "password")
User.create( first_name: "Brittney", last_name: "Van Valkenberg", user_type: "student", email: "Brittney@example.com", password: "password")
User.create( first_name: "Eiko", last_name: "Seino", user_type: "student", email: "Eiko@example.com", password: "password")
User.create( first_name: "Greg", last_name: "White", user_type: "student", email: "Greg@example.com", password: "password")
User.create( first_name: "Jeff", last_name: "Kynaston", user_type: "student", email: "Jeff@example.com", password: "password")
User.create( first_name: "Josh", last_name: "Jeong", user_type: "student", email: "Josh@example.com", password: "password")
User.create( first_name: "Kir", last_name: "Jarchow", user_type: "student", email: "Kir@example.com", password: "password")
User.create( first_name: "Kris", last_name: "Shanks", user_type: "student", email: "Kris@example.com", password: "password")
User.create( first_name: "Matias", last_name: "Meneses", user_type: "student", email: "Matias@example.com", password: "password")
User.create( first_name: "RJ", last_name: "Bernaldo", user_type: "student", email: "RJ@example.com", password: "password")
User.create( first_name: "Ronald", last_name: "Ishak", user_type: "student", email: "Ronald@example.com", password: "password")
User.create( first_name: "Ryan", last_name: "Stack", user_type: "student", email: "Ryan@example.com", password: "password")
User.create( first_name: "Sherwood", last_name: "Calloway", user_type: "student", email: "Sherwood@example.com", password: "password")
User.create( first_name: "Val", last_name: "Mitchell", user_type: "student", email: "Val@example.com", password: "password")
User.create( first_name: "Andra", last_name: "Lally", user_type: "student", email: "Andra@example.com", password: "password")
User.create( first_name: "Parjam", last_name: "Davoody", user_type: "student", email: "Parjam@example.com", password: "password")
User.create( first_name: "Phillip", last_name: "Crawford", user_type: "student", email: "Phillip@example.com", password: "password")
