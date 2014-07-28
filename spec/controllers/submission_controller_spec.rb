require 'spec_helper'

describe SubmissionController do
  describe '#create' do
    let(:submission_params) { FactoryGirl.attributes_for(:submission) }
    it "creates a new submission" do
      #arrange
        login = login_student
        user_id = login[0][0]
        user = User.find_by_id(user_id)
        classroom = FactoryGirl.create(:classroom)
        assignment = FactoryGirl.create(:assignment)
        params = {}
        assignment_id = assignment.id
        submission = {sub_title: submission_params[:sub_title], sub_content: submission_params[:sub_content]}
        classroom.assignments << assignment
        expect{post :create, assignment_id: assignment_id, submission: submission}.to change{Submission.count}.by(1)
    end
  end

  describe '#show' do
    it "returns the correct submission" do
      login = login_student
      user_id = login[0][0]
      user = User.find_by_id(user_id)
      #arrange
      assignment = FactoryGirl.create(:assignment)
      submission = FactoryGirl.build(:submission)
      submission.user_id = user_id
      submission.assignment_id = assignment.id
      submission.save
      #act
      get :show, id: submission.id
      #assert
      expect(assigns(:submission)).to eq(submission)
    end
  end

  describe '#update' do
    it 'updates the assignment in the database' do
    #arrange
      login = login_student
      user_id = login[0][0]
      user = User.find_by_id(user_id)
      submission = FactoryGirl.build(:submission)
      assignment = FactoryGirl.create(:assignment)
      assignment.submissions << submission
      params = {}
      submission_hash = {sub_title: 'dannys paper', submission_id: submission.id, sub_content: 'some updated content', assignment_id: assignment.id}
      submission_id = submission.id
    #act
      patch :update, id: submission_id, submission: submission_hash
      submission.reload
    #assert
    expect(submission.sub_title).to eq('dannys paper')
    end
  end
end
