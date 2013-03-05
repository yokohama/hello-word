#coding: utf-8
class Book < ActiveRecord::Base

  attr_accessible :title, :words

  has_many :book_words, :dependent => :delete_all
  has_many :words, :through => :book_words

  validates :title, presence:true

  # book_idの指定がない場合に、デフォルトライブラリ取得に使う。
  def self.library_new(user)
    current_user = User.find user.id
    self.new(title:'ライブラリ', words:current_user.words)
  end
end
