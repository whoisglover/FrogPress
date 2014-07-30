class Rubric < ActiveRecord::Base
  belongs_to :classroom
  has_many :rubric_categories, dependent: :destroy
  accepts_nested_attributes_for :rubric_categories
  # validates :classroom_id, presence: true
end
