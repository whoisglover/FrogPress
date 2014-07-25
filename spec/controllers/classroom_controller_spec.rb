require 'spec_helper'

describe ClassroomController do
  describe '#index' do
    it 'redirects to home if user is not logged in' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
    it 'return all classrooms for current teacher' do
      #arrange
        login = login_teacher
        #grab teacher id from login_teacher helper function
        teacher_id = login[0][0]
        #grab the teacher using the teacher id
        teacher = User.find_by_id(teacher_id)
        #create a new classroom
        classroom = FactoryGirl.create(:classroom)
        #assign the new classroom to the teacher
        teacher.classrooms << classroom

      #act
        get :index

      #assert
        expect(assigns(:classrooms)).to include(teacher.classrooms.first)
    end
    it 'return all classrooms for current student' do
      #arrange
        login = login_student
        #grab student id from login_student helper function
        student_id = login[0][0]
        #grab the student using the student id
        student = User.find_by_id(student_id)
        #create a new classroom
        classroom = FactoryGirl.create(:classroom)
        #assign the new classroom to the student
        student.classrooms << classroom

      #act
        get :index

      #assert
        expect(assigns(:classrooms)).to include(student.classrooms.first)
    end

    it 'should show the next 5 assignments due'



  end

  describe '#create' do
    it 'adds a valid classroom to the database' do
      #arrange
      classroom = FactoryGirl.create(:classroom)
      #act
      post :create, classroom: classroom
      #assert
      expect(Classroom.count).to eq

    end
    it 'does not add an invalid classroom to the database' do

    end
  end

  # describe '#update' do
  #   it 'update the classroom in the database' do

  #   end
  # end #end edit

  # describe '#destroy' do
  #   it 'should remove the classroom from the database' do
  #   end
  # end #end destroy

end #end ClassroomController
