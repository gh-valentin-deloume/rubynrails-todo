Rails.application.routes.draw do
  namespace :admin do
      resources :tasks

      root to: "tasks#index"
    end
  get "up" => "rails/health#show", as: :rails_health_check

  resources :tasks
end
