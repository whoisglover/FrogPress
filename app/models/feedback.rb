class Feedback < ActiveRecord::Base
  belongs_to :submission
  validates :submission_id, presence: true
end
