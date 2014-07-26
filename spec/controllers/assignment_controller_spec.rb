require 'spec_helper'

describe AssignmentController do
  describe "#show" do

    it 'directs to add assignment if user is teacher' do
      # arrange
        login = login_teacher
        classroom = FactoryGirl.create(:classroom)
        assignment = FactoryGirl.create(:assignment)
        classroom.assignments << assignment
      # act
         get :show, id: assignment.id
      # assert
        expect( assigns(:assignment) ).to eq(assignment)
    end
  end

  describe "#create" do
    let(:assignment_params) { FactoryGirl.attributes_for(:assignment)}
    let(:assignment_invalid_params) { FactoryGirl.attributes_for(:assignment_bad_params)}
    it "creates a new assignment" do
      # arrange
        login = login_teacher
        classroom = FactoryGirl.create(:classroom)
        assignment = FactoryGirl.create(:assignment)
        classroom.assignments << assignment
      #act/assert
        expect{
        post :create, assignment: assignment_params}.to change{Assignment.count}.by(1)
    end

    it 'does not create assignment without a classroom id' do
      login = login_teacher
      expect{
        post :create, assignment: assignment_invalid_params}.to change{Assignment.count}.by(0)
    end

  end


end
