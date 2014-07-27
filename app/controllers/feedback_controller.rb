class FeedbackController < ApplicationController
  before_filter :authenticate_user!
  def index
    p "!"*100
    p params
    @feedback = Feedback.where("submission_id=?", params[:submission_id])
  end

  def create
    if current_user.user_type == 'teacher'
      Feedback.create(submission_id: params[:submission_id], content: params[:content])
    end
      redirect_to (submission_path(params[:submission_id]))
  end
end
