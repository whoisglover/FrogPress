class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_user
  protect_from_forgery
  def show

    if current_user.id == params[:id].to_i
      # IF YOU ARE THE STUDENT YOU SEE ALL
      student = User.find_by_id(params[:id])
      submissions = []
      student.classrooms.each do |klass|
        subs_final =[]
        subs = student.submissions
        subs.each do |s|
          if s.get_class_id == klass.id
            subs_final << s
          end
        end
        class_and_subs = {klass: klass.id, submissions: subs_final}
        submissions << class_and_subs
      end
      @data = {student: student, submissions: submissions}
    elsif current_user.user_type == 'teacher'
      # IF YOU ARE THE TEACHER YOU ONLY SEE CLASSES YOU TEACH THAT THIS STUDENT IS IN
      submissions = []
      student = User.find_by_id(params[:id])
      class_matches = []
      possible_classes = student.classrooms
      possible_classes.each do |klass|
        klass.users.each do |user|
          if user.id == current_user.id
            class_matches << klass
          end
        end
      end
      class_matches.each do |klass|
        subs_final =[]
        subs = student.submissions
        subs.each do |s|
          if s.get_class_id == klass.id
            subs_final << s
          end
        end
        class_and_subs = {klass: klass.id, submissions: subs_final}
        submissions << class_and_subs
      end

      @data = {student: student, submissions: submissions}
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
