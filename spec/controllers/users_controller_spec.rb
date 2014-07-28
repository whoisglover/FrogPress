require 'spec_helper'

describe UsersController do
  describe '#show' do
    it 'should redirect to sign in if no user signed in' do
      #arrange
      #act
      get :show, id: 4
      #assert
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'should redirect to correct profile if not a teacher' do
      #arrange
      login = login_student
      #grab teacher id from login_teacher helper function
      student_id = login[0][0]
      #grab the student using the student id
      student = User.find_by_id(student_id)
      #act
      get :show, id: 4
      #assert
      expect(response).to redirect_to(user_path(student.id))
    end

    it 'should return the information for the user' do
      #arrange
      login = login_teacher
      #grab teacher id from login_teacher helper function
      teacher_id = login[0][0]
      #grab the teacher using the teacher id
      teacher = User.find_by_id(teacher_id)
      #act
      get :show, id: teacher.id
      #assert
      expect(assigns(:data)).to include(student: teacher)
    end
  end
end
