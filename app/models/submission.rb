class Submission < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :user
  validates :assignment_id, presence: true
  validates :user_id, presence: true
  has_many :feedbacks
  has_many :rubric_submissions


  def late?
    assignment.due_date < updated_at.to_date
  end

  def complete?
    status == "complete"
  end

  def get_class_id
    self.assignment.classroom.id
  end

  def check_class_id(class_id)
    self.assignment.classroom.id == class_id
  end

  def author_name
    student = User.find(self.user_id)
    return student.first_name + " " + student.last_name
  end
end
