require 'spec_helper'

describe Submission do
   let(:assignment) {FactoryGirl.create(:assignment)}
   let(:submission) {FactoryGirl.create(:submission)}
   let(:past_due_assignment) {FactoryGirl.create(:assignment, due_date: "2014-05-04")}

  context "Classroom Id for Submission" do
   it "returns the classroom id of a given submission" do
    assignment.submissions << submission
    expect(submission.get_class_id).to eq(assignment.classroom.id)
    end

    it "should check the class id" do
    assignment.submissions << submission
    expect(submission.check_class_id(assignment.classroom.id)).to be_true
    end
  end
  context "status" do
    it "shows a late assignment" do
      past_due_assignment.submissions << submission
      expect(submission.late?).to be_true
    end
      it "does not show a pending assignment as late" do
        assignment.submissions << submission
        expect(submission.late?).to be_false
      end
    it "shows a completed assignment" do
     submission_two = FactoryGirl.create(:submission, status:"complete")
     assignment.submissions << submission_two
     submission_two.reload
      expect(submission_two.complete?).to be_true
    end
    it "returns false for an incompleted assignment" do
      assignment.submissions << submission
      expect(submission.complete?).to be_false
    end
    #next test to add is when the submission is actually complete to come out to true. How do I change that attr?
  end
  context "author" do
    it "returns the first and last name of the user who submitted" do
      user = FactoryGirl.create(:student)
      user.submissions << submission
      expect(submission.author_name).to eq(submission.user.first_name+ " " + submission.user.last_name)
    end
  end
end

