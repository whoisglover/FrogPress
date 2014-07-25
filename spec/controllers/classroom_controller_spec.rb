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
  end #end index

  # describe '#create' do
  #   it 'adds a valid classroom to the database' do

  #   end
  #   it 'does not add an invalid classroom to the database' do

  #   end
  # end #end create

  # describe '#update' do
  #   it 'update the classroom in the database' do

  #   end
  # end #end edit

  # describe '#destroy' do
  #   it 'should remove the classroom from the database' do
  #   end
  # end #end destroy

end #end ClassroomController
