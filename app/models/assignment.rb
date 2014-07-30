class Assignment < ActiveRecord::Base
  belongs_to :classroom
  has_many :submissions
  validates :classroom_id, presence: true

  def self.find_submission_and_status(current_user, assignment)
    user_submissions = Submission.where(user_id: current_user.id)
    if user_submissions.length.zero?
      return nil
    end
    user_submissions.each do |submission|
      if submission.assignment_id == assignment.id
        if submission.status == "complete"
          return submission
        else
          return nil
        end
      end
    end
    return nil
  end

  def self.create_submission_data(current_user, completed_submission, assignment)
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


  # def self.create_submission_data(current_user, completed_submission, assignment)
  #   submission_data = {
  #     submission: Submission.new,
  #     sub_title_placeholder: "Your Essay Title",
  #     sub_content_placeholder: "Write your essay here!"
  #   }
  #   existing_submission = current_user.submissions.detect {|sub| sub.assignment_id == assignment.id} if completed_submission.present?
  #   return submission_data if existing_submission.blank?

  #   {
  #     submission: existing_submission,
  #     sub_title_placeholder: existing_submission.sub_title,
  #     sub_content_placeholder: existing_submission.sub_content
  #   }
  # end
end
