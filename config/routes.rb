Rails.application.routes.draw do
  devise_for :users
  get "users/show"

  resources :users
  resources :wikis do
    resources :collaborators
  end
  resources :charges, only: [:new, :create]

  post 'users/downgrade'
  
  get 'welcome/index'

  root to: 'welcome#index'
  
end
