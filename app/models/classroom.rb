class Classroom < ActiveRecord::Base
  has_many :users_classroom
  has_many :users, through: :users_classroom
  has_many :assignments
  validates :name, presence: true
  validates :grade_level, presence: true
  validates :join_code, presence: true
  validates :join_code, uniqueness: true

  def self.add_student_to_class(user_id, join_code)
    @classroom_to_add_student = Classroom.find_by_join_code(join_code)
    @classroom_to_add_student.users << User.find_by_id(user_id)
  end

end
