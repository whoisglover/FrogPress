class ClassroomController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery

  def index
    p 'hello'
    # if current_user.user_type != 'teacher'
      # redirect_to root_path, status: 303
    # end
  end

end
