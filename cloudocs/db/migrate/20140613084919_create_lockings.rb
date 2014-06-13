class CreateLockings < ActiveRecord::Migration
  def change
    create_table :lockings do |t|
      t.integer :file_id
      t.integer :user_id
      t.timestamp :lock_time

      t.timestamps
    end
  end
end
