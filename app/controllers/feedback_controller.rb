class FeedbackController < ApplicationController
  before_filter :authenticate_user!


  def create
    if current_user.user_type == 'teacher'
      # ////////////////////////// p params to see double nested hash feedback=>{submission_id: 5}
      p "!"*1000
      p params
      rubric_submissions_count = params[:rc_count].to_i
      p "RUBRIC SUBMISSIONS COUNT: #{rubric_submissions_count}"
      p "/" *100
      # p params[2..rubric_submissions_count-1]
      p "/" *100
      rubric_submissions = []
      subid = params[:feedback][:submission_id]
      params.each do |single_param|
        if single_param[0].to_i.to_s == single_param[0]
          rubric_category_id = single_param[0].to_i
          value = single_param[1].to_i
          rubric_submissions << RubricSubmission.create(rubric_category_id: rubric_category_id, score: value, submission_id: subid)
        end
      end
      # (2..(rubric_submissions_count-1)).each do |i|
      #   p params[i]
      # end
      # rubric_submissions_count.times do |i|
      #   real_index = (i+1).to_s
      #   # RubricSubmission.create(rubric_category_id: )
      #   p i+1
      #   p params[(i+1).to_s]
      # end
      content = params[:feedback][:content]
      feedbackprovider = params[:feedback][:feedback_provider]
      Submission.find(subid).update_attributes({status: "reviewed"})
# end
      Feedback.create(submission_id: subid, content: content, feedback_provider: feedbackprovider)
    end
      redirect_to (submission_path(subid))
  end




  private
  # def survey_params
  #   params.require(:feedback).permit(:submission_id, :content, :feedback_provider
  #     :rubric_submissions_attributes => [:id, :feedback_id, :rubric_category_id, :value])
  # end
end
