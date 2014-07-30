class Feedback < ActiveRecord::Base
  belongs_to :submission
  has_many :rubric_submissions
  validates :submission_id, presence: true
end
