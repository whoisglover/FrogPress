require 'spec_helper'

describe User do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:user) {FactoryGirl.create(:student)}
  let(:classroom) {FactoryGirl.create(:classroom)}
  let(:classroom_two) {FactoryGirl.create(:classroom)}
  let(:assignment) {FactoryGirl.create(:assignment)}
  let(:past_due_assignment) {FactoryGirl.create(:assignment, due_date: "2014-05-04")}
  let(:submission) {FactoryGirl.create(:submission)}

  context "charts" do
    it "displays the readability chart" do
      submission
      expect(User.new_readability_chart(submission.sub_title, 1)).to be_a LazyHighCharts::HighChart
    end
    it "diplays a status chart" do
      expect(User.new_status_chart(1,2,3)).to be_a LazyHighCharts::HighChart
    end
  end
  context "pending_assignments" do

    it "returns an array of assignments whose due date is today or later from all of a given users classrooms" do
      user.classrooms << classroom
      user.classrooms << classroom_two
      classroom.assignments << assignment
      expect(user.pending_assignments).to include(assignment)
    end
    #maybe go through more assignments - let 4 more assignments, users various classrooms etc
    #third classroom that didn't belong to the user
    it "does not return assignments whose due dates are in the past" do
      user.classrooms << classroom
      classroom.assignments << past_due_assignment
      expect(user.pending_assignments).not_to include(past_due_assignment)
    end
  end
  context "submissions" do
    it "returns the submission status of a users assignment" do
      user.classrooms << classroom
      classroom.assignments << assignment
      expect(user.submission_status(assignment)).to eq("incomplete")
    end
    it "finds a user's submission" do
      user.classrooms << classroom
      classroom.assignments << assignment
      assignment.submissions << submission
      user.submissions << submission

      expect(user.find_submission(assignment)).to eq(submission)
    end
  end
end
