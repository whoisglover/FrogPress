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
    @classroom = @assignment.classroom
    @students = student_roster(@classroom)
  end

  def edit
    @assignment = Assignment.find_by_id(params[:id])
  end

  def update
    assignment_hash = params[:assignment]
    assignment_hash = assignment_hash.to_hash
    assignment_hash.symbolize_keys!
    assignment_to_change = Assignment.find_by_id(params[:id])
    assignment_to_change.update(assignment_hash)
    redirect_to (classroom_path(assignment_to_change.classroom_id))
  end

  def destroy
    assignment = Assignment.find(params[:id])
    assignment.destroy
    redirect_to (classroom_path(assignment.classroom_id))
  end


private
  def verify_user
    if current_user.user_type == 'teacher' || current_user.user_type == 'student'
    else
      redirect_to (root_path)
    end
  end
end
