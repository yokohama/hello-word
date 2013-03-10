class BooksController < ApplicationController
  layout :except => [:new, :edit]

  def index
    books = current_user.books
    @library = books.shift
    @books = books
  end

  def show
    @book = Book.find params[:id]
    @words = @book.words
    @word = Word.new
    @books = current_user.books
  end

  def new
    @book = Book::Other.new
  end

  def edit
    @book = current_user.books.find(params[:id])
  end

  def create
    @book = Book::Other.new(params[:book])
    @book.user_id = current_user.id

    respond_to do |format|
      if @book.save
        flash[:notice] = 'success book created.'
        #format.json { render json: @book, status: :created, location: @book }
        format.json { render json: @book, status: :created }
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
        #format.json { render json: @book, status: :created, location: @book }
        format.json { render json: @book, status: :created }
      else
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book = current_user.books.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def sort
    disps = params[:book_ids].split(',');
    disps.each_with_index do |d, i|
      book = Book.find d
      book.display = i
      book.save
    end
    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
