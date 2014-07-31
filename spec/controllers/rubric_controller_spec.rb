require 'spec_helper'


describe RubricController do


  describe "new" do
    it 'should assign instance variable with a new rubric object' do
      #arrange
      teacher = login_teacher
      #act
      get :new
      #assert
      expect(assigns(:rubric).class).to eq(Rubric)
      expect(assigns(:rubric).id).to eq(nil)
    end
  end

  describe "create" do
    it 'requires a teacher to be logged in to create a rubric' do
      #arrrange
      classroom = FactoryGirl.create(:classroom)
      #act
      post :create, classroom_id: classroom.id
      #assert
      expect(Rubric.count).to eq(0)
    end
    it 'should create a new rubric given a classroom id' do
      #arrrange
      teacher = login_teacher
      classroom = FactoryGirl.create(:classroom)
      #act
      post :create, classroom_id: classroom.id
      #assert
      expect(Rubric.count).to eq(1)
    end

  end
  describe "show" do
    it 'returns a rubric given an id' do
      #arrange
      login = login_teacher
      rubric = Rubric.create(classroom_id: 1)
      #act
      get :show, id: rubric.id
      #assert
      expect(assigns(:rubric)).to eq(rubric)
    end
  end
  describe "edit" do

  end

  describe "update" do
  end

  describe "destroy" do
    it 'deletes a rubric if given the rubric id' do
      #arrange
      teacher = login_teacher
      rubric = Rubric.create(classroom_id: 1)
      #act
      delete :destroy, id: rubric.id
      #assert
      expect(Rubric.count).to eq(0)

    end
  end

end
