require 'spec_helper'

describe FeedbackController do
  describe "#index" do
    # it 'should return all feedback'
    it 'should return feedback for a given submission' do
      #arrange
      login_teacher
      submission = FactoryGirl.create(:submission)
      feedback = Feedback.create(content: "hey this was a great paper", submission_id: submission.id)
      feedback2 = Feedback.create(content: "I lied it actually wasnt great", submission_id: submission.id)
      #act
      get :index, submission_id: submission.id
      #assert
      expect(assigns(:feedback)).to include(Feedback.find_by_id(feedback.id))
      expect(assigns(:feedback)).to include(Feedback.find_by_id(feedback2.id))
    end

    describe "#show" do
      #is there ever a need to show a piece of feedback without the submission it is associated with?
    end
  end

  describe "#create" do
    it 'should create a new piece of feedback if content and submission_id are provided' do
      #arrange
      login_teacher
      submission = FactoryGirl.create(:submission)
      content = "Giving some feedback to my student here"
      #act
      post :create, submission_id: submission.id, content: content
      #assert
      expect(Feedback.count).to eq(1)
    end

    it 'should not create a new piece of feedback if submission_id is not given' do
      login_teacher
      submission = FactoryGirl.create(:submission)
      content = "Giving some feedback to my student here"
      #act
      post :create, content: content
      #assert
      expect(Feedback.count).to eq(0)
    end
    it 'should redirect to submission page' do
      #arrange
      login_teacher

      submission = FactoryGirl.create(:submission)
      content = "Giving some feedback to my student here"
      #act
      post :create, submission_id: submission.id, content: content
      #assert
      expect(response).to redirect_to(submission_path(submission.id))
    end

    it 'doesnt allow feedback to be created if no one is logged in' do
      #arrange
      submission = FactoryGirl.create(:submission)
      content = "Giving some feedback to my student here"
      #act
      post :create, submission_id: submission.id, content: content
      #assert
      expect(Feedback.count).to eq(0)
    end
    it 'only allows feedback to be created if the logged in user is a teacher' do
      #arrange
      login_student
      submission = FactoryGirl.create(:submission)
      content = "Giving some feedback to my student here"
      #act
      post :create, submission_id: submission.id, content: content
      #assert
      expect(Feedback.count).to eq(0)
    end

  end
end

describe "#update" do
  #should teachers be able to update a piece of feedback?
end

describe "#destroy" do
  #should teachers be able to delete a piece of feedback?
end


