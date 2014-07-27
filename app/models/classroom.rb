class Classroom < ActiveRecord::Base
  has_many :users_classroom
  has_many :users, through: :users_classroom
  has_many :assignments
  validates :name, presence: true
  validates :grade_level, presence: true
  validates :join_code, presence: true
  validates :join_code, uniqueness: true


  def all_assignments
    @these_assignments = self.assignments
  end

  def pending_assignments
    @these_pending_assignments = self.all_assignments.where("due_date >= ?", Date.today)
    @these_pending_assignments = @these_pending_assignments.sort_by(&:due_date).reverse
  end

  def past_due_assignments
    @these_past_due_assignments = self.all_assignments.where("due_date < ?", Date.today)
    @these_past_due_assignments = @these_past_due_assignments.sort_by(&:due_date).reverse
  end

  def student_roster
    @these_students = self.users.where("user_type = ?", "student")
  end

  def self.add_student_to_class(user_id, join_code)
    @classroom_to_add_student = Classroom.find_by_join_code(join_code)
    @classroom_to_add_student.users << User.find_by_id(user_id)
  end

end

