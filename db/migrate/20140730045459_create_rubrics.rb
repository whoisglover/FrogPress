class CreateRubrics < ActiveRecord::Migration
  def change
    create_table :rubrics do |t|
      t.string :title
      t.integer :classroom_id
      t.timestamps
    end
  end
end
