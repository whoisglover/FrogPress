class CreateRubricSubmissions < ActiveRecord::Migration
  def change
    create_table :rubric_submissions do |t|
      t.integer :submission_id
      t.integer :rubric_category_id
      t.integer :score
      t.timestamps
    end
  end
end
