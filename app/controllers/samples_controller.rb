#encoding: utf-8
require "csv"

class SamplesController < ApplicationController
=begin
  def update
    a = params[:files].split(",")
    p 'hogehogehogoehgoehgoe'
    p a.last.encoding
    p Base64.decode64(a.last)
  end
=end

  def update
    f = params[:file]
    book = current_user.books.find params[:book_id]
    csv = CSV.new(f)
    book.words.each do |w|
      #BUG:yokohama 関連も一緒に消す
      w.destroy
    end
    csv.each do |c|
      word = Word.new :word => c[0], :answer => c[1]
      word.user_id = current_user.id
      book.words << word
    end
  end
end
