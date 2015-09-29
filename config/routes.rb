Rails.application.routes.draw do
  
  get 'users/show'

  devise_for :users
  resources :users, only: [:show]

  resources :topics do
    resources :bookmarks, except: [:index] do
      resources :likes, only: [:create, :destroy]
    end
  end
  
  get "welcome/index"
  post '/incoming', to: 'incoming#create'
  
  root to: 'welcome#index'

end
