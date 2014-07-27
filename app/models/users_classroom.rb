class UsersClassroom < ActiveRecord::Base
  belongs_to :user
  belongs_to :classroom
  validates :user_id, uniqueness: {scope: :classroom_id, message: "You are already a member of this class"}
end
