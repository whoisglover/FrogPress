class UsersClassroom < ActiveRecord::Base
  belongs_to :user
  belongs_to :classroom
end
