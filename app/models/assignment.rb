class Assignment < ActiveRecord::Base
  belongs_to :classroom
  has_many :submissions
  validates :classroom_id, presence: true
end
