Helloword::Application.routes.draw do

  devise_for :users

  #root :to => 'words#index'
  root :to => 'dashboard#index'

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

end
