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

        # go through all submissions and sort by classroom
        @student.submissions.each do |s|
          if @submissions_by_classroom[s.get_class_id]
            @submissions_by_classroom[s.get_class_id] << s
          end
        end

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
