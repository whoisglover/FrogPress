class ClassroomController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_user
  protect_from_forgery

  def index
    @classrooms = current_user.classrooms
  end

  def create
    @classroom = Classroom.create(name: params[:classroom][:name], grade_level: params[:classroom][:grade_level], join_code: params[:classroom][:join_code])
    # @classroom = Classroom.create(params[:classroom])

    redirect_to (classroom_path(@classroom.id))
  end

  def show
    @classroom = Classroom.find_by_id(params[:id])
  end

  def update
    attr_hash = params[:attrs]
    # attr_hash[:grade_level] = attr_hash[:grade_level].to_i
    attr_hash = attr_hash.to_hash
    # symbolize the keys of hash of update params
    p attr_hash.class
    attr_hash.symbolize_keys!
    #find the classroom to change
    @classroom_to_change = Classroom.find_by_id(params[:id])
    # perform update
    @classroom_to_change.update(attr_hash)
    redirect_to classroom_path(@classroom_to_change.id)
  end

  def destroy
    Classroom.find_by_id(params[:id]).destroy
    redirect_to(classroom_index_path)
  end

  def new

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
