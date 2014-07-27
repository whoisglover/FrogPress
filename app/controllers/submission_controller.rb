class SubmissionController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_user
  protect_from_forgery


  def new
    # pass assignment id and student id to form.  Pass from form in to the create route.
  end

  def show
    @submission = Submission.find_by_id(params[:id])
  end

  def create
    @user_id = params[:user_id].to_i
    submission_hash = params[:submission]
    submission_hash = submission_hash.to_hash
    submission_hash.symbolize_keys!
    p submission_hash
    submission = Submission.create(submission_hash)
    redirect_to (assignment_path(submission.assignment_id))
  end


  # def edit
  # end

  def update
    @subid = params[:id].to_i
    submission = Submission.find_by_id(@subid)
    submission_hash = params[:new_params]
    submission_hash = submission_hash.to_hash
    submission_hash.symbolize_keys!
    submission.update(submission_hash)
    redirect_to (submission_path(@subid))
  end

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
