Rails.application.routes.draw do
  root to: "stations#index"



  #User routes
  get 'sign_up', to: 'users#new'
  post 'sign_up', to: 'users#create'
  get "login", to: 'sessions#new'
  post 'login', to: 'sessions#create'

  #Sessions routes
  delete 'logout', to: 'sessions#destroy'
  
  match 'rent', to: "stations#rent", via: :get
  match 'membership', to: "stations#membership", via: :get

  resources :charges, only: [:new, :create]
  # get '/card/new' => 'charges#new', as: :add_payment

end

