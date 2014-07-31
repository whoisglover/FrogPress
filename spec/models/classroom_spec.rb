require 'spec_helper'

describe Classroom do
  context "assignments" do
    let(:classroom) {FactoryGirl.create(:classroom)}
    let(:past_due_assignment) {FactoryGirl.create(:assignment, due_date: "2014-05-04")}

    it "displays all assignments for a given classroom" do
      my_classroom = classroom
      5.times { FactoryGirl.create(:assignment) }
      my_classroom.reload
      my_classroom.assignments.first(5).each do |assignment|
        expect(my_classroom.all_assignments).to include(assignment)
      end
    end
    it "returns assignments whose due date is today or in the future" do
      assignment = FactoryGirl.create(:assignment)
      my_classroom = Classroom.find(assignment.classroom_id)
      expect(my_classroom.pending_assignments).to include(assignment)
    end
    it "does not return assignments whose due date is in the past" do
      classroom
      past_due_assignment
      expect(classroom.pending_assignments).to_not include(past_due_assignment)
    end

    it "returns the pending assignments in order" do
      my_classroom = classroom
      5.times { FactoryGirl.create(:assignment) }
      classroom.reload
      sorted_assignments = classroom.assignments.first(5).sort_by{|assignment| assignment.due_date}
      expect(classroom.pending_assignments).to eq(sorted_assignments)
    end
    it "returns assignments who due date is in the past" do
      late_assignment = classroom.assignments.create(due_date: Date.today - 6)
      expect(classroom.past_due_assignments).to include(late_assignment)
    end
  end

  context "student" do
    let(:classroom) {FactoryGirl.create(:classroom)}
    let(:student) {FactoryGirl.create(:student)}
    let(:teacher) {FactoryGirl.create(:teacher)}

    it "returns users that are students" do
      classroom.users.create(user_type: 'student')
      the_teacher = classroom.users.create(user_type: 'teacher')

      expect(classroom.student_roster.all? { |user| user.user_type ='student'}).to be_true
      expect(classroom.users).to include(the_teacher)
      expect(classroom.student_roster).to_not include(the_teacher)
    end
    it "adds a student to a class" do
      student
      classroom
      Classroom.add_student_to_class(student.id,classroom.join_code)
      expect(student.classrooms).to include(classroom)
    end
  end
  context "teacher" do
     let(:classroom) {FactoryGirl.create(:classroom)}
    let(:student) {FactoryGirl.create(:student)}
    let(:teacher) {FactoryGirl.create(:teacher)}

    it "should only return users that are teachers" do
      my_class = classroom
      my_class.users
      new_teacher = my_class.users.create(user_type: 'teacher', email: 'email@email.com', password: 'password')
      my_class.users.create(user_type: 'student', email: 'email2@email.com', password: 'password')
      expect(my_class.teacher).to eq(new_teacher)
    end
  end
end
