Rails.application.routes.draw do
  get 'incoming/controller'

  devise_for :users
  get 'user/show'

  get 'welcome/index'

  root to: 'welcome#index'
end
