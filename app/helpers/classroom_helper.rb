module ClassroomHelper
  def classroom_create_redirect(classroom)
    if classroom.id
      redirect_to classroom_index_path
    else
      redirect_to new_classroom_path
    end
  end

  def student_add_classroom(join_code)
    if current_user.classrooms.include?(Classroom.find_by_join_code(join_code))
      redirect_to classroom_index_path
    else
      Classroom.add_student_to_class(params[:classroom][:id], params[:classroom][:join_code])
      redirect_to classroom_index_path
    end
  end
end
