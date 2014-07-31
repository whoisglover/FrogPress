require 'spec_helper'

describe Classroom do
  context "assignments" do
    let(:classroom) {FactoryGirl.create(:classroom)}
    it "displays all assignments for a given classroom" do
      5.times {classroom.assignments << FactoryGirl.create(:assignment)}
      classroom.assignments.first(5).each do |assignment|
      expect(classroom.all_assignments).to include(assignment)
      end
    end
  end
    it "returns assignments whose due date is today or in the future" do

    end
    it "returns the pending assignments in order" do
    end

  context "student" do
  end
  context "teacher" do
  end
end
