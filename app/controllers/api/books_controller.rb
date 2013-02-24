class Api::BooksController < ApplicationController

  skip_before_filter :verify_authenticity_token ,:only=>[:index]

  def index
    user = params[:user]
    @user = User.find_by_email user[:email]
    if @user
      if @user.valid_password? user[:password]
        books = [Book.library_new(@user)]
        words = []
        @user.books.each do |b|
          books << b
        end
        json_books = []
        books.each do |b|
          json_books << b.as_json(:include => :words)
        end
        #render status:200, :json=>{books:books}
        render status:200, :json=>{books:json_books}
      else
        render status:400, :json=>{:message=>"Error :password"}
      end
    else
      render status:400, :json=>{:message=>"Error :email"}
    end
    
  end
end

