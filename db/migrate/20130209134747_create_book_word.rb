class CreateBookWord < ActiveRecord::Migration

  def self.up
    create_table :book_words do |t| 
      t.references :book
      t.references :word
      t.timestamps
    end
  end

  def self.down
    drop_table :book_words
  end

end
