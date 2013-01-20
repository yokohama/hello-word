class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :keyword
      t.string :discription

      t.timestamps
    end
  end
end
