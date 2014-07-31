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
      @submissions_by_classroom = make_classroom_hash(@student.classrooms)
      @submissions = Submission.where(user_id: @student.id)
      @num_complete_submissions = @submissions.where(status: "complete").length
      @num_not_submitted = @submissions.length - @submissions.where(status: "complete").length
      @num_late_submissions = 0

      # go through all submissions and sort by classroom
      # check against assignment due date to get # of late submissions
      @student.submissions.each do |s|
        # Refactor to s.late? in new branch
        if Assignment.find_by_id(s.assignment_id).due_date < s.updated_at
          @num_late_submissions += 1
        end

        if @submissions_by_classroom[s.get_class_id]
          @submissions_by_classroom[s.get_class_id] << s
        end
      end

      @num_on_time = @num_complete_submissions - @num_late_submissions

      @submissions = Submission.where(user_id: @student.id)
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
