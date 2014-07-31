class RubricSubmission < ActiveRecord::Base
  belongs_to :feedback
  validates :rubric_category_id, uniqueness: {scope: :submission_id}
  # validates :submission_id, presence: true
  # validates :rubric_category_id, presence: true
  # validates :score, presence: true
end
