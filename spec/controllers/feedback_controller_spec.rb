require 'spec_helper'

describe FeedbackController do

    describe "#show" do
      #is there ever a need to show a piece of feedback without the submission it is associated with?
    end

  describe "#create" do
    it 'should create a new piece of feedback if content and submission_id are provided' do
      #arrange
      login_teacher
      submission = FactoryGirl.create(:submission)
      content = "Giving some feedback to my student here"
      feedback = {submission_id: submission.id, content: content}
      #act
      post :create, feedback: feedback
      #assert
      expect(Feedback.count).to eq(1)
    end

    it 'should not create a new piece of feedback if submission_id is not given' do
      login_teacher
      submission = FactoryGirl.create(:submission)
      content = "Giving some feedback to my student here"
      feedback = {submission_id: nil, content: content}
      #act
      post :create, feedback: feedback
      #assert
      expect(Feedback.count).to eq(0)
    end

    it 'should redirect to submission page' do
      #arrange
      login_teacher

      submission = FactoryGirl.create(:submission)
      content = "Giving some feedback to my student here"
      feedback = {submission_id: submission.id, content: content}
      #act
      post :create, feedback: feedback
      #assert
      expect(response).to redirect_to(submission_path(submission.id))
    end

    it 'doesnt allow feedback to be created if no one is logged in' do
      #arrange
      submission = FactoryGirl.create(:submission)
      content = "Giving some feedback to my student here"
      feedback = {submission_id: submission.id, content: content}
      #act
      post :create, feedback: feedback
      #assert
      expect(Feedback.count).to eq(0)
    end
    it 'only allows feedback to be created if the logged in user is a teacher' do
      #arrange
      login_student
      submission = FactoryGirl.create(:submission)
      content = "Giving some feedback to my student here"
      feedback = {submission_id: submission.id, content: content}

      #act
      post :create, feedback: feedback
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


