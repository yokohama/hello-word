class WordsController < ApplicationController
  layout :except => [:index]

  before_filter :authenticate_user!

  def index
    @book = current_user.books.find(params[:book_id])
    if @book.library?
      @words = current_user.words.find_all
    else
      @words = @book.words
    end
  end

  def show
    @word = Word.find(params[:id])
  end

  def swipe
    @words = Word.all
  end

  def new
    @word = Word.new
    @book = current_user.books.find(params[:book_id])
  end

  def edit
    @word = Word.find(params[:id])
  end

  def create
    @word = Word.new(params[:word])
    @word.user_id = current_user.id

    respond_to do |format|
      if @word.save
        if params[:book_id]
          BookWord.create(book_id:params[:book_id], word_id:@word.id)
        end
        flash[:notice] = 'success word created.'
        format.json { render json: @word, status: :created}
      else
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @word = Word.find(params[:id])
    if @word.update_attributes(params[:word])
      redirect_to word_path(@word)
    else
      render action: "edit"
    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    redirect_to words_path
  end

  #checkbox選択での複数削除
  def destroy_all

    words = []
    params[:words].split(',').each do |id|
      words << current_user.words.find(id)
    end
    
    book = Book.find params[:book_id]
    words.each do |w|
      if book.library? #ライブラリの場合は、マスター削除
        w.destroy
      else #Bookの場合は関連削除
        BookWord.where(book_id:params[:book_id], word_id:w.id).each {|_bw| _bw.destroy }
      end
    end

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def iframe
    @book = current_user.books.find params[:book_id]
    @words = @book.library? ? current_user.words.find_all : @book.words
  end

  def validation
    #TODO:yokohama ここでどんなファイルがきても内容をUTF-8に変換してあげる。
    @cv = CsvValidate.new(params[:file])
    @cv.validate
  end

  def file_upload
    book = current_user.books.find params[:book_id]
    @cv = CsvValidate.new(params[:file])
    new_record_count = Book::TOLERANCE - book.words.count
    @cv.to_words(current_user).each_with_index do |w, i|
      book.words << w if (i < new_record_count)
    end
    respond_to do |format|
      format.html{ head :no_content }
    end
  end

end
