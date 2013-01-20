#coding: utf-8
class Word < ActiveRecord::Base
 attr_accessible :keyword, :discription
 validates_length_of :keyword, :within => 1..40, :message => "は1〜40文字以内で入力して下さい"
 validates_length_of :discription, :within => 1..255, :message => "は1〜255文字以内で入力して下さい"
end
