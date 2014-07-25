require 'spec_helper'

describe AssignmentController do
  describe "#show" do
    it 'shows a specific assignment for a class'  do
      login = login_teacher
      #grab teacher id from login_teacher helper function
      teacher_id = login[0][0]
      #grab the teacher using the teacher id
      teacher = User.find_by_id(teacher_id)
      #create a new classroom
      classroom = FactoryGirl.create(:classroom)
      #creates a new assignment
      assignment = FactoryGirl.create(:assignment)
      #assigns the assignment to a classroom
      classroom << assignment
      #assign the new classroom to the teacher
      teacher.classrooms << classroom


    #act
      get :show, id: assignment.id

    #assert
      expect(assigns(:classrooms)).to include(teacher.classrooms.first)

    end
  end


end
