require 'spec_helper'

describe ClassroomController do
  describe '#index' do
    it 'redirects to home if user is not logged in' do
      #arrange
      student = FactoryGirl.create(:student)
      current_user = student
      current_user = nil || current_user.user_type == 'teacher'
      #act
      get :index
      #assert
      expect(response).to redirect_to('/')
    end
    # it 'return all classrooms for current teacher' do
    #   #arrange
    #   teacher = FactoryGirl.create(:teacher)
    #   current_user = teacher
    #   #act
    #   get :index
    #   #assert

    # end
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
