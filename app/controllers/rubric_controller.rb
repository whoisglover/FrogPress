class RubricController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_teacher
  protect_from_forgery

  def show

    @rubric = Rubric.find_by_id(params[:id])
    redirect_to rubric_path(params[:id])
  end


  def create
    Rubric.create(classroom_id: params[:classroom_id])
    redirect_to root_path
  end

  def destroy
    Rubric.find_by_id(params[:id]).destroy
    redirect_to root_path
  end


end

def verify_teacher
  if current_user.user_type != 'teacher'
    redirect_to root_path
  end
end
