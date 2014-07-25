class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title
      t.string :content
      t.date :due_date
      t.timestamps
    end
  end
end
