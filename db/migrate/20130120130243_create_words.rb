class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word, null:false
      t.string :answer
      t.integer :user_id, null:false

      t.timestamps
    end
    add_index :words, :word
  end
end
