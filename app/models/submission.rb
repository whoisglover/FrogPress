class Submission < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :user
  validates :assignment_id, presence: true
  validates :user_id, presence: true
  has_many :feedbacks

  def get_class_id
    self.assignment.classroom.id
  end

  def check_class_id(class_id)
    self.assignment.classroom.id == class_id
  end
end
