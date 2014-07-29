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

    # Move to model when MVP done
    if current_user.user_type == "student"

      @completed_submission = Assignment.find_submission_and_status(current_user, @assignment)

      if @completed_submission == nil
        @user_submissions = User.find(current_user.id).submissions
        if @user_submissions.length == 0
          @submission = Submission.new
          @sub_title_placeholder = "Your Essay Title"
          @sub_content_placeholder = "Write your essay here!"
        else
          @user_submissions.each do |sub|
            if sub.assignment_id == @assignment.id
              @submission = sub
              @sub_title_placeholder = @submission.sub_title
              @sub_content_placeholder = @submission.sub_content
              break
            else
              @submission = Submission.new
              @sub_title_placeholder = "Your Essay Title"
              @sub_content_placeholder = "Write your essay here!"
            end
          end
        end
      end
    end
  end

  def edit
    @assignment = Assignment.find_by_id(params[:id])
    @classroom = @assignment.classroom_id
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
