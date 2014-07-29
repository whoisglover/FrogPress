class Rubric < ActiveRecord::Base
  belongs_to :classroom
  has_many :rubric_categories
  validates :classroom_id, presence: true


end
