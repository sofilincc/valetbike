Rails.application.routes.draw do
  root to: "stations#index"



  #User routes
  get 'sign_up', to: 'users#new'
  post 'sign_up', to: 'users#create'
  get "login", to: 'sessions#new'
  post 'login', to: 'sessions#create'

  #Sessions routes
  get 'logout', to: 'sessions#destroy'
  post 'logout', to: 'stations#index'

  match 'rent', to: "stations#rent", via: :get
  match 'membership', to: "users#membership", via: :get
  #match 'success', to: "checkouts#success", via: :get

  resources :charges, only: [:new, :create]



  namespace :purchase do
    resources :checkouts
  end

  get 'success', to: 'checkouts#success'
  resources :subscriptions
  

  


  #api from webchrunch
  #require 'sidekiq'

  # authenticate :user, lambda { |u| u.admin? } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end


  # devise_for :users

  # Add 3 these lines below
  scope controller: :static do
    get 'pricing'
  end
  
  match 'pricing', to: "static#pricing", via: :get
  #root to: 'home#index'
  
end
