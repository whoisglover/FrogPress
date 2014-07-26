require 'spec_helper'

describe SubmissionController do
  describe "#create" do
    let(:submission_params) { FactoryGirl.attributes_for(:submission) }
    it "creates a new submission" do
      #arrange
        login = login_student
        student_id = login[0][0]
        student = User.find_by_id(student_id)
        classroom = FactoryGirl.create(:classroom)
        assignment = FactoryGirl.create(:assignment)
        classroom.assignments << assignment
        # submission = FactoryGirl.create(:submission)
        # assignment.submissions << submission
        # student.submissions << submission
      #act/assert
        expect{
          post :create, submission: submission_params, assignment: assignment.id}.to change{Submission.count}.by(1)
    end
  end
end
