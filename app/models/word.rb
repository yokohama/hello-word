#coding: utf-8
class Word < ActiveRecord::Base

  attr_accessible :word, :answer, :user_id

  has_many :book_words, :dependent => :delete_all
  has_many :books, :through => :book_words

  #validates_length_of :word, :within => 1..40
  #validates_length_of :answer, :within => 1..255
end
