Rails.application.routes.draw do
  get "home/index"
  devise_for :users, path: '', path_names: {
    sign_in: 'sign_in',
    sign_out: 'sign_out',
    sign_up: 'sign_up',
    password: 'password',
    confirmation: 'confirmation',
    unlock: 'unlock'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :posts do
    resources :comments
    resources :likes
  end
  # Defines the root path route ("/")
  root "home#index"
end
