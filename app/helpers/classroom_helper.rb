module ClassroomHelper
  def classroom_create_redirect(classroom)
    if classroom.id
      redirect_to classroom_index_path
    else
      redirect_to new_classroom_path
    end
  end


end
