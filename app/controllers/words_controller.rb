class WordsController < ApplicationController
  def index
    @words = Word.all
  end

  def show
    @word = Word.find(params[:id])
  end

  def swipe
    @words = Word.all
  end

  def new
    @word = Word.new
  end

  def edit
    @word = Word.find(params[:id])
  end

  def create
    @word = Word.new(params[:word])
    if @word.save
      redirect_to words_path
    else
      render action: "new"
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
  end
end
