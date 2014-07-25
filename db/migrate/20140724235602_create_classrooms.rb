class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :name
      t.integer :teacher_id
      t.integer :grade_level
      t.string :join_code
      t.timestamps
    end
  end
end
