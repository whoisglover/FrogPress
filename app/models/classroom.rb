class Classroom < ActiveRecord::Base
  has_many :users_classroom
  has_many :users, through: :users_classroom
  has_many :assignments
  validates :name, presence: true
  validates :grade_level, presence: true
  validates :join_code, presence: true
  validates :join_code, uniqueness: true

end
