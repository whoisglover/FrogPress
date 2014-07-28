class AssignmentController < ApplicationController
  include AssignmentHelper
  before_filter :authenticate_user!
  before_filter :verify_user
  protect_from_forgery


  def new
  end

  def create
    assignment_hash = params[:assignment]
    assignment_hash = assignment_hash.to_hash
    assignment_hash.symbolize_keys!
    assignment = Assignment.create(assignment_hash)
    redirect_to (classroom_path(assignment.classroom_id))
  end

  def show
    @assignment = Assignment.find_by_id(params[:id])
    @classroom = @assignment.classroom
    @students = student_roster(@classroom)

    if current_user.user_type == "student"
      user_submissions = Submission.where(user_id: current_user.id)
      if user_submissions.length != 0 # User has submissions
        user_submissions.each do |submission|
          p "** iteration through user's submissions **"
          if submission.assignment_id == @assignment.id && submission.status != "complete"
            p "INCOMPLETE ASSIGNMENT "
            p @completed_submission
            @completed_submission = nil
            break
          elsif submission == user_submissions.last && submission.assignment_id == @assignment.id
           @completed_submission = submission
           p "COMPLETE ASSIGNMENT "
            p @completed_submission
          end
        end
      else
        @completed_submission = nil # User has no submissions so this is nil
      end
    end
  end

  def edit
    @assignment = Assignment.find_by_id(params[:id])
  end

  def update
    assignment_hash = params[:assignment]
    assignment_hash = assignment_hash.to_hash
    assignment_hash.symbolize_keys!
    assignment_to_change = Assignment.find_by_id(params[:id])
    assignment_to_change.update(assignment_hash)
    redirect_to (classroom_path(assignment_to_change.classroom_id))
  end

  def destroy
    assignment = Assignment.find(params[:id])
    assignment.destroy
    redirect_to (classroom_path(assignment.classroom_id))
  end


private
  def verify_user
    if current_user.user_type == 'teacher' || current_user.user_type == 'student'
    else
      redirect_to (root_path)
    end
  end
end
