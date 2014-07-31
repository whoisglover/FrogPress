class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_user
  protect_from_forgery

  def make_classroom_hash(classrooms)
    classroom_hash = {}

    classrooms.each do |klass|
      if (current_user.user_type == "student" || klass.teacher == current_user)
        classroom_hash[klass.id] = []
      end
    end

    return classroom_hash
  end

  def show
    # IF YOU ARE THE STUDENT OR TEACHER
    if current_user.id == params[:id].to_i || current_user.user_type == 'teacher'

      @student = User.find_by_id(params[:id])
      @submissions_by_classroom = make_classroom_hash(@student.classrooms)
      @submissions = Submission.where(user_id: @student.id)
      @num_complete_submissions = @submissions.where(status: "complete").length
      @num_not_submitted = @submissions.length - @submissions.where(status: "complete").length
      @num_late_submissions = 0

      # go through all submissions and sort by classroom
      # check against assignment due date to get # of late submissions
      @student.submissions.each do |s|
        # Refactor to s.late? in new branch
        if Assignment.find_by_id(s.assignment_id).due_date < s.updated_at
          @num_late_submissions += 1
        end

        if @submissions_by_classroom[s.get_class_id]
          @submissions_by_classroom[s.get_class_id] << s
        end
      end

      @num_on_time = @num_complete_submissions - @num_late_submissions

      @submissions = Submission.where(user_id: @student.id)
      @submission_titles = []
      @submission_readability_scores = []

      @submissions.each do |submission|
        @submission_titles << submission.sub_title.split[0...4].join(' ')
        @submission_readability_scores << Lingua::EN::Readability.new(submission.sub_content).kincaid.round(2)
      end

      @readability_chart =

      @submissions_chart = LazyHighCharts::HighChart.new('pie') do |f|
        f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
        series = {
          :type=> 'pie',
          :name=> 'Submissions',
          :data=> [
            ['On Time', @num_on_time],
            ['Not Submitted', @num_not_submitted],
            ['Late', @num_late_submissions]
          ]
        }
        f.series(series)
        f.options[:title][:text] = "Submissions"
        f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'})
        f.plot_options(:pie=>{
                         :allowPointSelect=>true,
                         :cursor=>"pointer" ,
                         :dataLabels=>{
                           :enabled=>true,
                           :color=>"black",
                           :style=>{
                             :font=>"13px Trebuchet MS, Verdana, sans-serif"
                           }
                         }
        })
      end
    else
      redirect_to(user_path(current_user.id))
    end
  end

  private
  def verify_user
    if current_user.user_type == 'teacher'
      # nothing to see here, move along
    elsif current_user.user_type == 'student'
    else
      redirect_to (root_path)
    end
  end
end
