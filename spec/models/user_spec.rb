require 'spec_helper'

describe User do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "pending_assignments" do
    let(:user) {FactoryGirl.create(:student)}
    let(:classroom) {FactoryGirl.create(:classroom)}
    let(:classroom_two) {FactoryGirl.create(:classroom)}
    let(:assignment) {FactoryGirl.create(:assignment)}
    let(:past_due_assignment) {FactoryGirl.create(:assignment, due_date: Date.yesterday)}
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
end
