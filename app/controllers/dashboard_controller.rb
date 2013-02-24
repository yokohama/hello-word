class DashboardController < ApplicationController

  before_filter :authenticate_user!

  def index
    if params[:book_id]
      @book = current_user.books.find params[:book_id]
      @words = @book.words
    else
      @words = current_user.words
    end
    @word = Word.new
    @books = current_user.books
  end

end
