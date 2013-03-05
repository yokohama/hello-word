class WordsController < ApplicationController
  layout :except => [:index]

  before_filter :authenticate_user!

  def index
    if (params[:book_id].to_i == 0) 
      @words = current_user.words
    else
      @book = current_user.books.find(params[:book_id])
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
    @book = params[:book_id].to_i == 0 ? Book.library_new(current_user) : current_user.books.find(params[:book_id])
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
    
    words.each do |w|

      #ライブラリの場合は、マスター削除
      if params[:book_id].to_i == 0
        w.destroy

      #Bookの場合は関連削除
      else
        BookWord.where(book_id:params[:book_id], word_id:w.id).each {|_bw| _bw.destroy }
      end
    end

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def iframe
    if params[:book_id].to_i == 0
      @book = Book.library_new(current_user)
    else
      @book = current_user.books.find params[:book_id]
    end
  end

  def validation
    #TODO:yokohama ここでどんなファイルがきても内容をUTF-8に変換してあげる。
    @cv = CsvValidate.new(params[:file])
    @cv.validate
  end

  def file_upload
    book = current_user.books.find params[:book_id]
    book.words.each do |w|
      #BUG:yokohama 関連も一緒に消す
      w.destroy
    end
    @cv = CsvValidate.new(params[:file])
    @cv.to_words(current_user).each do |w|
      book.words << w
    end
    respond_to do |format|
      format.html{ head :no_content }
    end
  end

end

