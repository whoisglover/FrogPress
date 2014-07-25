require 'spec_helper'

describe ClassroomController do
  describe '#index' do
    it 'redirects to home if user is not logged in' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
    it 'return all classrooms for current teacher' do
      #arrange
      teacher = FactoryGirl.create(:teacher)
      classroom = FactoryGirl.create(:classroom)
      classroom.teacher_id = teacher.id
      current_user = teacher
      #act
      get :index
      #assert
      expect(assigns(:classrooms)).to include(classroom)
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
