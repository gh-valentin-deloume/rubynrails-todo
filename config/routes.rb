Rails.application.routes.draw do
  resources :tasks
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :admin do
    resources :tasks
    resources :users

    root to: 'tasks#index'
  end
end
