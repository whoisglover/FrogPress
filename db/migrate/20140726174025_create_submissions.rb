class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :assignment_id
      t.integer :user_id
      t.string :sub_title
      t.text :sub_content
      t.string :status
      t.timestamps
    end
  end
end
