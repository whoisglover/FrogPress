class SubmissionController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_user
  protect_from_forgery


  def new
    # pass assignment id and student id to form.  Pass from form in to the create route.
  end

  def create
    # submission = Submission.create(params[:submission]
    @assignment_id = params[:assignment].to_i
    submission_hash = params[:submission]
    submission_hash = submission_hash.to_hash
    submission_hash.symbolize_keys!
    assignment = Assignment.find_by_id(@assignment_id)
    submission = Submission.create(submission_hash)
    assignment.submissions << submission
    redirect_to (classroom_path(submission.assignment.classroom_id))
  end

  # def show
  # end

  # def edit
  # end

  # def update
  # end

  # def destroy
  # end

private
  def verify_user
    if current_user.user_type == 'teacher'
    elsif current_user.user_type == 'student'
    else
      redirect_to (root_path)
    end
  end
end
