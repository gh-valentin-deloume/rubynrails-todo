Rails.application.routes.draw do
  resources :tasks

  namespace :admin do
    resources :tasks

    root to: 'tasks#index'
  end
end
