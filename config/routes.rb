Helloword::Application.routes.draw do

  devise_for :users, :controllers => {
    sessions:'users/sessions'
  }

  #as :user do
  #  post 'sign_in_by_mobile_player' => "users/sessions#create_by_mobile_player", as:'user_session_by_mobile_player'
  #end

  root to:'dashboard#index'

  match '/dashboard/:book_id' => 'dashboard#index'

  resources :books do
    resources :words do
      collection do
        get :swipe
        delete :destroy_all
        match '/iframe' => 'words#iframe'
      end
    end
  end

  as :user do
    namespace :api do
      namespace :users do
        post 'sign_in_by_mobile' => "sessions#create_by_mobile"
      end
    end
  end

end
