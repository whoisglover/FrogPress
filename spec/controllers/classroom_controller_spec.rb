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
    let(:classroom_params) { FactoryGirl.attributes_for(:classroom) }
    let(:bad_classroom_params) { FactoryGirl.attributes_for(:invalid_classroom) }

    it 'adds a valid classroom to the database' do
      #arrange
      login = login_teacher
      #act
      #assert
      expect{
        post :create, classroom: classroom_params
      }.to change{Classroom.count}.by(1)
    end
    it 'does not add an invalid classroom to the database' do
      #arrange
      login = login_teacher
      #act
      #assert
      expect{
        post :create, classroom: bad_classroom_params
      }.to change{Classroom.count}.by(0)
    end
  end

  describe '#show' do
    it 'returns the correct classroom' do
      #arrange
      login = login_teacher
      #act
      classroom = FactoryGirl.create(:classroom)
      get :show, id: classroom.id
      #assert
      expect(assigns(:classroom)).to eq(classroom)
    end

    it 'redirects to homepage if you are not logged in to the system' do
      #arrange
      #act
      classroom = FactoryGirl.create(:classroom)
      get :show, id: classroom.id
      #assert
      expect(response).to redirect_to(new_user_session_path)
    end

  end
  describe '#update' do
    let(:classroom) { FactoryGirl.create(:classroom) }
    it 'updates the classroom in the database' do
      #arrange
      login_teacher
      original_classroom = classroom
      #act
      patch :update, id: classroom.id, attrs: {name: "Brennon", grade_level: 1}
      new_classroom = Classroom.find_by_id(classroom.id)
      #assert
      expect(new_classroom.name).to_not eq(original_classroom.name)
    end
  end #end edit

  describe '#destroy' do
    let(:classroom) { FactoryGirl.create(:classroom) }
    it 'should remove the classroom from the database' do
      #arrange
      login_teacher
      #act
      delete :destroy, id: classroom.id
      #assert
      expect(Classroom.count).to eq(0)
    end
  end #end destroy

  describe "#remove_student" do
    it 'removes a given student from the given class' do
      #arrange
      login_teacher
      student = FactoryGirl.create(:student)
      classroom = FactoryGirl.create(:classroom)
      classroom.users << student
      #act

      delete :remove_student, {classid: classroom.id, userid: student.id}
      #assert
      expect(classroom.users.count).to eq(0)
    end
  end
end #end ClassroomController
