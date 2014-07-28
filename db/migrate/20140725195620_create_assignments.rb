class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :classroom_id
      t.string :title
      t.text :content
      t.date :due_date
      t.timestamps
    end
  end
end
