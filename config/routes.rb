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

  resources :charges, only: [:new, :create]


end
