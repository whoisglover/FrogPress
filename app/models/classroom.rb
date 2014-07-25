class Classroom < ActiveRecord::Base
  has_many :users_classroom
  has_many :users, through: :users_classroom
end
