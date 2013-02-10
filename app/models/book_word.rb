#coding: utf-8
class BookWord < ActiveRecord::Base

  attr_accessible :book_id, :word_id

  belongs_to :book
  belongs_to :word
end
