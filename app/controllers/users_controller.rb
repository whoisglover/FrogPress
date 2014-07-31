class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_user
  protect_from_forgery

  def make_classroom_hash(classrooms)
    classroom_hash = {}

    classrooms.each do |klass|
      if (current_user.user_type == "student" || klass.teacher == current_user)
        classroom_hash[klass.id] = []
      end
    end

    return classroom_hash
  end

  def show
    # IF YOU ARE THE STUDENT OR TEACHER
    if current_user.id == params[:id].to_i || current_user.user_type == 'teacher'

      @student = User.find_by_id(params[:id])

      # Get all student's submissions
      @submissions = @student.submissions

      # get all the student's classes with their submissions in hash for display
      @submissions_by_classroom = make_classroom_hash(@student.classrooms)
      @submissions.each do |s|
         if @submissions_by_classroom[s.assignment.classroom.id]
          @submissions_by_classroom[s.assignment.classroom.id] << s
         end
      end


      # get the submissions where the assignments have already passed their due date
      submissions_past_due = []
      @submissions.each do |s|
        if s.assignment.due_date < Date.today
          submissions_past_due << s
        end
      end

      @num_on_time = 0
      @num_not_submitted = 0
      @num_late_submissions = 0


      # Sort into submitted late OR submitted on time OR not turned in
      submissions_past_due.each do |s|
        if s.status == 'incomplete'
          @num_not_submitted +=1
        elsif s.updated_at > s.assignment.due_date + 1
          @num_late_submissions +=1
        else
          @num_on_time +=1
        end
      end


      # get data for the Readability graph
      @submission_titles = []
      @submission_readability_scores = []

      @submissions.each do |submission|
        @submission_titles << submission.sub_title.split[0...4].join(' ')
        @submission_readability_scores << Lingua::EN::Readability.new(submission.sub_content).kincaid.round(2)
      end
      @readability_chart = User.new_readability_chart(@submission_titles, @submission_readability_scores)

      @submissions_chart = User.new_status_chart(@num_on_time, @num_not_submitted, @num_late_submissions)
    else
      redirect_to(user_path(current_user.id))
    end
  end


  private
  def verify_user
    if current_user.user_type == 'teacher'
      # nothing to see here, move along
    elsif current_user.user_type == 'student'
    else
      redirect_to (root_path)
    end
  end
end
