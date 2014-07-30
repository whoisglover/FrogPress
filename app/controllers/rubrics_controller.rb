class RubricsController < ApplicationController

  def new
    cat1 = RubricCategory.new

    # cat1 = RubricCategory.create(title: "danny", level1: "do")
    # cat2 = RubricCategory.create(title: "dann2y")

    @rubric = Rubric.new
    @users = User.all
    @rubric.rubric_categories << cat1
    # @rubric.rubric_categories << cat2
    @rubric_categories = @rubric.rubric_categories
  end

  def create
    p "!"*100
    p params[:rubric]
    Rubric.create(params[:rubric].symbolize_keys)
    redirect_to root_path
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
