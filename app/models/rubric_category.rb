class RubricCategory < ActiveRecord::Base
  belongs_to :rubric
  validates :rubric_id, presence: true
  validates :title, presence: true
  validates :level1, presence: true
  validates :level2, presence: true
  validates :level3, presence: true
  validates :level4, presence: true
  validates :level5, presence: true

end
