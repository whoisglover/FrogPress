require 'spec_helper'

describe AssignmentController do
  describe "#create" do
    let(:assignment_params) { FactoryGirl.attributes_for(:assignment)}
    let(:assignment_invalid_params) { FactoryGirl.attributes_for(:assignment_bad_params)}
    it "creates a new assignment" do
      # arrange
        login_teacher
        classroom = FactoryGirl.create(:classroom)
        assignment = FactoryGirl.create(:assignment)
        classroom.assignments << assignment
      #act/assert
        expect{
        post :create, assignment: assignment_params}.to change{Assignment.count}.by(1)
    end

    it 'does not create assignment without a classroom id' do
      login_teacher
      expect{
        post :create, assignment: assignment_invalid_params}.to change{Assignment.count}.by(0)
    end
  end


  describe "#show" do
    it 'adds assignment if user is teacher' do
      # arrange
        login_teacher
        classroom = FactoryGirl.create(:classroom)
        assignment = FactoryGirl.create(:assignment)
        classroom.assignments << assignment
      # act
         get :show, id: assignment.id
      # assert
        expect( assigns(:assignment) ).to eq(assignment)
    end
  end

  describe "#update" do
    let(:assignment) { FactoryGirl.create(:assignment) }
    let(:assignment_params) { FactoryGirl.attributes_for(:assignment)}
    it "updates the specified assignment with new parameters in the database" do
      # arrange
        login_teacher
        original_assignment = Assignment.create(title: "test title", content: "test_content", due_date: "11-01-2014")
      # act
        put :update, { id: assignment.id, assignment: assignment_params }
        assignment.reload
      # assert
        expect(assignment.title).to eq(assignment_params[:title])
    end

    it "should redirect the user to the classroom_path" do
      login_teacher
      put :update, {id: assignment.id, assignment: assignment_params }
      expect(response).to redirect_to(classroom_path(assignment.classroom_id))
    end
  end

  describe "#destroy" do
    let(:assignment) { FactoryGirl.create(:assignment) }
    it 'should remove the assignment from the database' do
      login_teacher
      assignment
      expect {delete :destroy, id: assignment.id}.to change{Assignment.count}.by(-1)
    end

    it "should redirect the user to the classroom_path" do
      login_teacher
      delete :destroy, id: assignment.id
      expect(response).to redirect_to(classroom_path(assignment.classroom_id))
    end
  end
end
