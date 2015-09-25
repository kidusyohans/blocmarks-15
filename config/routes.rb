Rails.application.routes.draw do
  post :incoming, to: 'incoming#create'

  devise_for :users
  get 'user/show'

  get 'welcome/index'

  root to: 'welcome#index'
end
