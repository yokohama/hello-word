class DashboardController < ApplicationController

  before_filter :authenticate_user!

  def index
    if params[:book_id]
      @book = current_user.books.find params[:book_id]
    else
      @book = current_user.books.find_by_type Book::Library
    end
    @words = @book.words
    @word = Word.new
    @books = current_user.books
  end

end
