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



  # def create_assignment

  # end
end

