class ClassroomController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_teacher
  protect_from_forgery

  def index
    @classrooms = current_user.classrooms
  end

  private
  def verify_teacher
    if current_user.user_type == 'teacher'
      # nothing to see here, move along
    else
      redirect_to (root_path)
    end
  end
end
