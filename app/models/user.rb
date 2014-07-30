class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :users_classroom
  has_many :classrooms, through: :users_classroom
  has_many :submissions

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
