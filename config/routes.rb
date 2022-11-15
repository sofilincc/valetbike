Rails.application.routes.draw do
  root to: "stations#index"

  match 'rent', to: "stations#rent", via: :get
  match 'membership', to: "stations#membership", via: :get

end