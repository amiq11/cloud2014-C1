class CreateFileStats < ActiveRecord::Migration
  def change
    create_table :file_stats do |t|
      t.string :name
      t.string :path
      t.string :password
      t.integer :user_id
      t.boolean :private
      t.timestamp :last_update

      t.timestamps
    end
  end
end
