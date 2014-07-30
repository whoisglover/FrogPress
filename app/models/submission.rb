class Submission < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :user
  validates :assignment_id, presence: true
  validates :user_id, presence: true
  has_many :feedbacks

  def get_class_id
    assignment = Assignment.find_by_id(self.assignment_id)
    return nil if assignment == nil
    classroom = Classroom.find_by_id(assignment.classroom_id)
    classroom.id
  end

  def check_class_id(class_id)
    assignment = Assignment.find_by_id(self.assignment_id)
    classroom = Classroom.find_by_id(assignment.classroom_id)
    classroom.id == class_id
  end
end
