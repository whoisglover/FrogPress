class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_user
  protect_from_forgery
  def show
    # p "!" *100
    request.original_url
    p "current user: #{current_user.id}"
    p "params: #{params}"
    if current_user.id == params[:id].to_i || current_user.user_type == 'teacher'
      @user = User.find_by_id(params[:id])
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
