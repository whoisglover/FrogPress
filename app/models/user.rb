class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :users_classroom
  has_many :classrooms, through: :users_classroom
  has_many :submissions

  def self.new_readability_chart(submission_titles, submission_readability_scores)
    LazyHighCharts::HighChart.new('spline') do |f|
      f.title(:text => "Flesch-Kincaid Readability Score")
      f.xAxis(:categories => submission_titles)
      f.series(:name => "Readability Score", :yAxis => 0, :data => submission_readability_scores)

      f.yAxis [
        {:title => {:text => "Score by Grade Level", :margin => 70} },
      ]

      f.chart({:defaultSeriesType=>"spline"})
    end
  end

  def self.new_status_chart(num_on_time, num_not_submitted, num_late_submissions)
    LazyHighCharts::HighChart.new('pie') do |f|
        f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
        series = {
          :type=> 'pie',
          :name=> '',
          :data=> [
            ['On Time', num_on_time],
            ['Not Submitted', num_not_submitted],
            ['Late', num_late_submissions]
          ]
        }
        f.series(series)
        f.options[:title][:text] = ""
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

  end

  def pending_assignments
    pending_assignments = []
    self.classrooms.each do |klass|
      pending_assignments += klass.assignments.where("due_date >= ?", Date.today)
    end
    return pending_assignments.sort_by(&:due_date)
  end

  def submission_status(assignment)
    submission = self.submissions.where('assignment_id = ?', assignment.id)
    return "incomplete" if submission.length == 0
    return submission[0].status
  end

  def find_submission(assignment)
      return self.submissions.where('assignment_id = ?', assignment.id)[0]
  end
end
