class Assignment < ActiveRecord::Base
  belongs_to :classroom
  has_many :submissions
  validates :classroom_id, presence: true

  def self.find_submission_and_status(current_user, assignment)
    user_submissions = Submission.where(user_id: current_user.id)
      if user_submissions.length != 0 # User has submissions
        user_submissions.each do |submission|
          if submission.assignment_id == assignment.id && submission.status == "incomplete" # Not complete
            return completed_submission = nil
          elsif submission.assignment_id == assignment.id  && submission.status == "complete" # Assignment Complete
            return completed_submission = submission
          end
        end
      else
        return completed_submission = nil # User has no submissions so this is nil, Not complete
      end
  end
end
