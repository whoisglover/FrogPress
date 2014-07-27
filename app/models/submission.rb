class Submission < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :user
  # validates :assignment_id, presence: true
  # validates :user_id, presence: true
end
