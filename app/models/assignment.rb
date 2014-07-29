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

  def self.create_submission_data(completed_submission)
    if completed_submission == nil
      user_submissions = User.find(current_user.id).submissions
      if user_submissions.length == 0
        submission = Submission.new
        sub_title_placeholder = "Your Essay Title"
        sub_content_placeholder = "Write your essay here!"
      else
        user_submissions.each do |sub|
          if sub.assignment_id == assignment.id
            submission = sub
            sub_title_placeholder = submission.sub_title
            sub_content_placeholder = submission.sub_content
            break
          else
            submission = Submission.new
            sub_title_placeholder = "Your Essay Title"
            sub_content_placeholder = "Write your essay here!"
          end
        end
      end
    end
    return {submission: submission, sub_title_placeholder: sub_title_placeholder, sub_content_placeholder: sub_content_placeholder}
  end
end
