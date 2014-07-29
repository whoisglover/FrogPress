class FeedbackController < ApplicationController
  before_filter :authenticate_user!


  def create
    if current_user.user_type == 'teacher'
      # ////////////////////////// p params to see double nested hash feedback=>{submission_id: 5}
      p "/"*120
      p params
      subid = params[:feedback][:submission_id]
      content = params[:feedback][:content]
      Feedback.create(submission_id: subid, content: content)
    end
      redirect_to (submission_path(subid))
  end
end
