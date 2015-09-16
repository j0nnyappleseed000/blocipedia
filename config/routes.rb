Rails.application.routes.draw do
  devise_for :users
  get "users/show"

  resources :users do
    resources :wikis
  end
  
  get 'welcome/index'

  root to: 'welcome#index'
end
