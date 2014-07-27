class ClassroomController < ApplicationController
  include ClassroomHelper
  before_filter :authenticate_user!
  before_filter :verify_user
  protect_from_forgery

  def remove_student
    classid = params[:classid].to_i
    userid = params[:userid].to_i
    this_class = Classroom.find_by_id(classid)
    this_class.users.delete(userid)
    redirect_to(classroom_path(params[:classid]))
  end


  def index
    @classrooms = current_user.classrooms
    @assignments = []
    @classrooms.each do |klass|
      if klass.assignments[0]
         @assignments << klass.assignments
      end
    end
    @assignments.flatten!
    @assignments = @assignments.sort_by(&:due_date).reverse
    @data = {classrooms: @classrooms, assignments: @assignments}
  end

  def create
    if current_user.user_type == "teacher"
      @classroom = Classroom.create(name: params[:classroom][:name], grade_level: params[:classroom][:grade_level], join_code: params[:classroom][:join_code])
      @classroom.users << current_user
      classroom_create_redirect(@classroom)
    else
      Classroom.add_student_to_class(params[:classroom][:id], params[:classroom][:join_code])
      redirect_to (user_path(params[:classroom][:id]))
    end
  end

  def show
    @classroom = Classroom.find_by_id(params[:id])
    if current_user.user_type == 'teacher'
      render partial: 'teacher', locals: {classroom: @classroom}
    else
      render partial: 'student', locals: {classroom: @classroom}
    end

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
