class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :type
      t.string :title, null:false
      t.integer :user_id, null:false
      t.integer :display
      t.attachment :cover

      t.timestamps
    end
  end
end
