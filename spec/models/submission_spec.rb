require 'spec_helper'

describe Submission do
  context "Classroom Id for Submission" do
   let(:assignment) {FactoryGirl.create(:assignment)}
   let(:submission) {FactoryGirl.create(:submission)}

   it "returns the classroom id of a given submission" do
    assignment.submissions << submission
    expect(submission.get_class_id).to eq(assignment.classroom.id)
    end
  end

  it "should check the class id" do
  end

end

