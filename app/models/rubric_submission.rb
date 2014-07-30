class RubricSubmission < ActiveRecord::Base
  belongs_to :submission
  validates :submission_id, presence: true
  validates :rubric_category_id, presence: true
  validates :score, presence: true
end
