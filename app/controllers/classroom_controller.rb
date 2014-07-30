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

    render :json => {:success => true}

  end

  def index
    @classrooms = current_user.classrooms
    @assignments = current_user.pending_assignments[0..4]
  end

  def create
    if current_user.user_type == "teacher"
      @classroom = Classroom.create(name: params[:classroom][:name], grade_level: params[:classroom][:grade_level], join_code: params[:classroom][:join_code])
      @classroom.users << current_user
      classroom_create_redirect(@classroom)
    else
      student_add_classroom(params[:classroom][:join_code])
    end
  end

  def show
    @classroom = Classroom.find_by_id(params[:id])
    @teacher = @classroom.teacher
    render "_#{current_user.user_type}"
  end


  def update

    if (params[:flag] == "true")
      p "!"*500
      p params

      render :json => {:success => true}
    else
      attr_hash = params[:attrs]
    # attr_hash[:grade_level] = attr_hash[:grade_level].to_i
    attr_hash = attr_hash.to_hash
    # symbolize the keys of hash of update params
    attr_hash.symbolize_keys!
    #find the classroom to change
    @classroom_to_change = Classroom.find_by_id(params[:id])
    # perform update
    @classroom_to_change.update(attr_hash)
    redirect_to classroom_path(@classroom_to_change.id)
  end
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
