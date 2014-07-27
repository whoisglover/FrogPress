class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :content
      t.integer :submission_id
      t.timestamps
    end
  end
end
