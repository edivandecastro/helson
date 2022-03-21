Rails.application.routes.draw do
  get '/oauth/authorize', to: 'authorizations#new'
  post '/oauth/authorize', to: 'authorizations#create'
  delete '/oauth/authorize/:id', to: 'authorizations#destroy'
  resources :applications
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
