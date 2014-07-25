class ClassroomController < ApplicationController
  protect_from_forgery

  def index
    @classrooms = Classroom.all
  end

end
