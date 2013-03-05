class BooksController < ApplicationController
  layout :except => [:new, :edit]

  def index
    @books = current_user.books
  end

  def show
    if params[:id].to_i == 0
      @book = Book.library_new current_user
      @words = @book.words
    else
      @book = Book.find params[:id]
      @words = @book.words
    end
    @word = Word.new
    @books = current_user.books
  end

  def new
    @book = Book.new
  end

  def edit
    if params[:id].to_i == 0
      @book = Book.library_new(current_user)
    else
      @book = current_user.books.find(params[:id])
    end
  end

  def create
    @book = Book.new(params[:book])
    @book.user_id = current_user.id

    respond_to do |format|
      if @book.save
        flash[:notice] = 'success book created.'
        format.json { render json: @book, status: :created, location: @book }
      else
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @book = current_user.books.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        flash[:notice] = 'success book updated.'
        format.json { render json: @book, status: :created, location: @book }
      else
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book = current_user.books.find(params[:id])
    #BookWord.where(book_id:@book.id).each do |bw|
    #  bw.destroy
    #end
    @book.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
