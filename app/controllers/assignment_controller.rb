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

    if @assignment == nil
      redirect_to (root_path)
      p "!"
    end

    @classroom = @assignment.classroom

    @students = student_roster(@classroom)

    if current_user.user_type == "student"
      @completed_submission = Assignment.find_submission_and_status(current_user, @assignment)
      @submission_data = Assignment.create_submission_data(current_user, @completed_submission, @assignment)
      @submission = @submission_data[:submission]
      @sub_title_placeholder = @submission_data[:sub_title_placeholder]
      @sub_content_placeholder = @submission_data[:sub_content_placeholder]

    else
      submissions = @assignment.submissions
      # Before the due date
      if @assignment.due_date >= Date.today
        not_started = @students.count - submissions.count
        started = submissions.where("status = ?", "incomplete").count
        finished = submissions.where("status = ? OR status = ?", "complete", "reviewed").count
        student_stats = [["not_started", not_started], ["finished", finished], ["started", started]]
      else
      #after the due date
        not_started = @students.count - submissions.count
        not_finished = submissions.where("status = ?", "incomplete").count
        not_submitted = not_started + not_finished
        on_time = 0
        late = 0
        submissions.each do |s|
          if s.status != 'incomplete' && s.updated_at <= @assignment.due_date
            on_time +=1
          elsif s.status != 'incomplete'
            late +=1
          end
        end
        student_stats = [['Not Submitted', not_submitted], ['On Time', on_time], ['Late', late]]
      end


      @submissions_chart = Assignment.new_submission_data_chart(student_stats)
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
    redirect_to (assignment_path(assignment_to_change))
  end

  def destroy
    assignment = Assignment.find(params[:id])
    assignment.destroy

    render :json => {:success => true}
  end


  private
  def verify_user
    if current_user.user_type == 'teacher' || current_user.user_type == 'student'
    else
      redirect_to (root_path)
    end
  end
end
