Messaging::Application.routes.draw do

  devise_for :users, path: "accounts"

  resources :users do 
    resources :messages do
      member do
        post 'create_response'
      end
    end
  end



root :to => "home#index"

end
