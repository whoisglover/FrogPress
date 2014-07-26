class AssignmentController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_user
  protect_from_forgery

  def show
    @assignment = Assignment.find_by_id(params[:id])
  end

  def new
    # pass classroom id to form. Pass from form in to create route.
  end

  def create
    assignment_hash = params[:assignment]
    assignment_hash_hash = assignment_hash.to_hash
    assignment_hash_hash.symbolize_keys!
    assignment = Assignment.create(assignment_hash_hash)
    redirect_to (classroom_path(assignment.classroom_id))
  end


private
  def verify_user
    if current_user.user_type == 'teacher'
    else
      redirect_to (root_path)
    end
  end
end
