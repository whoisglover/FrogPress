class RubricsController < ApplicationController


  def show
    @rubric = Rubric.find_by_id(params[:id])
    if @rubric.nil?
      redirect_to root_path
    end
  end
  def new
    cat1 = RubricCategory.new
    cat2 = RubricCategory.new
    cat3 = RubricCategory.new
    cat4 = RubricCategory.new

    @rubric = Rubric.new
    @users = User.all
    @rubric.rubric_categories << cat1 << cat2 << cat3 << cat4
    @rubric_categories = @rubric.rubric_categories
  end

  def edit
    @rubric = Rubric.find_by_id(params[:id])
    @rubric_categories = @rubric.rubric_categories
  end

  def create
    p "!"*100
    p params[:rubric]
    Rubric.create(params[:rubric].symbolize_keys)
    redirect_to root_path
  end

  def update
    p "??"*100
    p params
    Rubric.find_by_id(params[:id]).update(params[:rubric].symbolize_keys)
    redirect_to rubric_path(params[:id])
  end


  def rubric_categories
    @rubric_categories = @rubric.rubric_categories
  end


  private
  def survey_params
    params.require(:rubric).permit(:classroom_id, :title,
      :rubric_categories_attributes => [:id, :rubric_id, :title, :level1, :level2, :level3, :level4, :level5])
  end
end


{"title"=>"DANNYSRUBRIC", "rubric_categories_attributes"=>{"0"=>{"title"=>"CAT!", "level1"=>"level 1 yoshi", "level2"=>"lvl 2 bowser", "level3"=>"lvl3 peach", "level4"=>"lvl4 toad", "level5"=>"lvl5 luigi"}}}
