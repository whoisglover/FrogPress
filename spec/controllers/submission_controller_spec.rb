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
        submission_params[:user_id] = user_id
        submission_params[:assignment_id] = assignment.id
        classroom.assignments << assignment
        params = {user_id: user_id, submission: submission_params}
      #act/assert
        expect{post :create, params}.to change{Submission.count}.by(1)
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
      submission.user_id = user_id
      submission.save
      subid = submission.id
      new_params = {sub_title: 'dannys paper'}
    #act
      patch :update, id: subid, new_params: new_params
      submission.reload
    #assert
    expect(submission.sub_title).to eq('dannys paper')
    end
  end
end
