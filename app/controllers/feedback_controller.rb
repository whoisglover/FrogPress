class FeedbackController < ApplicationController
  before_filter :authenticate_user!


  def create
    if current_user.user_type == 'teacher'
      # ////////////////////////// p params to see double nested hash feedback=>{submission_id: 5}
      subid = params[:feedback][:submission_id]
      content = params[:feedback][:content]
      feedbackprovider = params[:feedback][:feedback_provider]
      Submission.find(subid).update_attributes({status: "reviewed"})

      Feedback.create(submission_id: subid, content: content, feedback_provider: feedbackprovider)
    end
      redirect_to (submission_path(subid))
  end




  private
  def survey_params
    params.require(:feedback).permit(:submission_id, :content, :feedback_provider
      :rubric_submissions_attributes => [:id, :feedback_id, :rubric_category_id, :value])
  end
end
