class UsersClassroom < ActiveRecord::Migration
  def change
    create_table :users_classroom do |t|
      t.integer :user_id
      t.integer :classroom_id
    end
  end
end
