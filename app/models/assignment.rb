class Assignment < ActiveRecord::Base
  belongs_to :classroom
  validates :classroom_id, presence: true
end
