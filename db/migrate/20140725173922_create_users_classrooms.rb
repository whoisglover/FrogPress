class CreateUsersClassrooms < ActiveRecord::Migration
  def change
    create_table :users_classrooms do |t|
      t.integer :user_id
      t.integer :classroom_id
      t.timestamps
    end
  end
end
