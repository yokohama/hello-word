Helloword::Application.routes.draw do
  root :to => "words#index"
  resources :words do
    collection do
      get :swipe
    end
  end
end
