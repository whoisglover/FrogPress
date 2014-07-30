class Feedback < ActiveRecord::Base
  belongs_to :submission
  has_many :rubric_submissions
  validates :submission_id, presence: true
  accepts_nested_attributes_for :rubric_submissions
end
