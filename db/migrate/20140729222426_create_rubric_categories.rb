class CreateRubricCategories < ActiveRecord::Migration
  def change
    create_table :rubric_categories do |t|
      t.integer  :rubric_id
      t.string :title
      t.text :level1
      t.text :level2
      t.text :level3
      t.text :level4
      t.text :level5
      t.timestamps
    end
  end
end
