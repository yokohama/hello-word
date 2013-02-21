class Api::Users::SessionsController < Devise::SessionsController

  skip_before_filter :verify_authenticity_token ,:only=>[:create_by_mobile]

  # POST /resource/sign_in for iPhone & Android login
  def create_by_mobile
    user = params[:user]
    @user = User.find_by_email user[:email]
    if @user
      if @user.valid_password? user[:password]
        render :status=>200, :json=>{:message=>"Success"}
      else
        render :status=>400, :json=>{:message=>"Error :password"}
      end
    else
      render :status=>400, :json=>{:message=>"Error :email"}
    end
  end
end
