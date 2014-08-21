require 'spec_helper'

describe Assignment do
  let(:assignment) {FactoryGirl.create(:assignment)}
  let(:submission) {FactoryGirl.create(:submission)}
  let(:user) {FactoryGirl.create(:student)}
  let(:classroom) {FactoryGirl.create(:classroom)}
  context "submission status" do
    it "creates a new submission chart" do
      expect(Assignment.new_submission_data_chart(1,2,3)).to be_a LazyHighCharts::HighChart
    end
    it "does not find a submission if a user has not submitted" do
      user.classrooms << classroom
      classroom.assignments << assignment
      assignment.submissions << submission
      user.submissions << submission
      expect(Assignment.find_submission_and_status(user, assignment)).to eq(nil)
    end
    it "finds a submission for a user and return nil" do
      user.classrooms << classroom
      classroom.assignments << assignment
      user.submissions.create(sub_title: "hey", sub_content: "content", status: "draft", assignment_id: assignment.id)
      expect(Assignment.find_submission_and_status(user, assignment)).to eq(nil)
    end
    it "finds a complete submission for a user and returns the submission" do
      user.classrooms << classroom
      classroom.assignments << assignment
     new_submission = user.submissions.create(sub_title: "hey", sub_content: "content", assignment_id: assignment.id, status: "complete")
      expect(Assignment.find_submission_and_status(user, assignment)).to eq(new_submission)
    end
    it "creates new submission data" do
      user.classrooms << classroom
      classroom.assignments << assignment
      #new variable
      submission = Submission.new
        sub_title_placeholder = "Your Essay Title"
        sub_content_placeholder = "Write your essay here!"
    expect(Assignment.create_submission_data(user, nil, assignment)).to include(sub_title_placeholder: sub_title_placeholder)
    end
  end
end
