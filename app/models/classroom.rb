class Classroom < ActiveRecord::Base
  has_many :users_classrooms
  has_many :users, through: :users_classrooms
  has_many :assignments
  validates :name, presence: true
  validates :grade_level, presence: true
  validates :join_code, presence: true
  validates :join_code, uniqueness: true

  alias :all_assignments :assignments

  def pending_assignments
    return  all_assignments.where("due_date >= ?", Date.today).sort_by(&:due_date)
  end

  def past_due_assignments
    return all_assignments.where("due_date < ?", Date.today).sort_by(&:due_date)
  end

  def student_roster
    users.where("user_type = ?", "student")
  end

  def self.add_student_to_class(user_id, join_code)
    @classroom_to_add_student = Classroom.find_by_join_code(join_code)
    @classroom_to_add_student.users << User.find_by_id(user_id)
  end

  def teacher
    return users.where('user_type = ?', 'teacher')[0]
  end

end

