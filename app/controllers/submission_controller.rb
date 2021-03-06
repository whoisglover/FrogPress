class SubmissionController < ApplicationController
  include SubmissionsHelper
  before_filter :authenticate_user!
  before_filter :verify_user
  protect_from_forgery


  def new
    # pass assignment id and student id to form.  Pass from form in to the create route.
  end

  def show
    @submission = Submission.find_by_id(params[:id])
    @student = @submission.user
    @assignment = @submission.assignment
    @classroom = @assignment.classroom
    feedback = @submission.feedbacks.first
    feedback?(feedback)
  end

  def create
    if params[:commit] == "Submit"
      @status = "complete"
    elsif params[:commit] == "Save"
      @status = "incomplete"
    else
      p "WARNING: submission status unknown. Consult Brennon if this confuses you."
    end
    @user_id = current_user.id.to_i
    @assignment_id = params[:assignment_id]
    @sub_title = params[:submission][:sub_title]
    @sub_content = params[:submission][:sub_content]
    @submission = Submission.create(user_id: @user_id, assignment_id: @assignment_id, sub_title: @sub_title, sub_content: @sub_content, status: @status)
    @classroom_id = Assignment.find_by_id(@assignment_id).classroom_id
    redirect_to (classroom_path(@classroom_id))
    #redirect_to (assignment_path(@submission.assignment_id))
  end


  def edit
    @submission = Submission.find_by_id(params[:id])
    @assignment = Assignment.find_by_id(@submission.assignment_id)
  end

  def update
    if params[:commit] == "Submit"
      @status = "complete"
    elsif params[:commit] == "Save"
      @status = "incomplete"
    else
      p "WARNING: submission status unknown. Consult Brennon if this confuses you."
    end
    #debugger
    @submission = Submission.find_by_id(params[:submission][:submission_id])
    @submission.update(sub_title: params[:submission][:sub_title], sub_content: params[:submission][:sub_content], status: @status)
    @submission.save
    @classroom_id = Assignment.find_by_id(params[:submission][:assignment_id]).classroom_id
    redirect_to (classroom_path(@classroom_id))
    #redirect_to (submission_path(@submission.id))
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
