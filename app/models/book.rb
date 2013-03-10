#coding: utf-8
class Book < ActiveRecord::Base

  TOLERANCE = 200

  attr_accessible :user_id, :title, :words, :cover, :cover_content_type

  has_many :book_words, :dependent => :delete_all
  has_many :words, :through => :book_words
  has_attached_file :cover, :styles => { :medium => "300x300>", :thumb => "100x100>", :mobile => "50x50>" }

  validates :title, presence:true
  validates_attachment_size :cover, :less_than => 1.megabytes
  validates_attachment_content_type :cover, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  def tolerance?
    words.size < TOLERANCE
  end

  def permissible_count
    TOLERANCE - words.size
  end

  def library?
    self.type == 'Book::Library'
  end
end
