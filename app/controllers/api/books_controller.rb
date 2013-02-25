class Api::BooksController < ApplicationController

  skip_before_filter :verify_authenticity_token ,:only=>[:index]

  def index
    user = params[:user]
    @user = User.find_by_email user[:email]
    if @user
      if @user.valid_password? user[:password]
        books = [Book.library_new(@user)]
        words = []
        logger.info("@user=#{@user.inspect}")
        logger.info("books=#{@user.books.inspect}")
        @user.books.each do |b|
          books << b
        end
        json_books = []
        books.each do |b|
          logger.info("words=#{b.as_json(:include => :words)}")
          json_books << b.as_json(:include => :words)
        end
        logger.info("json_books=#{json_books.inspect}")
        render status:200, :json=>{books:json_books}
      else
        render status:400, :json=>{:message=>"Error :password"}
      end
    else
      render status:400, :json=>{:message=>"Error :email"}
    end
    
  end
end

