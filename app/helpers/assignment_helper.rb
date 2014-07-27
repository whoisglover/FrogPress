module AssignmentHelper
  def student_roster(classroom)
    all_users = classroom.users.all
    return_students(all_users)
  end

  def return_students(user_array)
    students = []
    user_array.each do |user|
      if user.user_type = "student"
        students << user
      end
    end
    students
  end


end
