Rails.application.routes.draw do
  get '/oauth/authorize', to: 'authorizations#new'
  post '/oauth/authorize', to: 'authorizations#create'
  delete '/oauth/authorize/:id', to: 'authorizations#destroy'
  post '/oauth/token', to: 'tokens#create'
  post '/oauth/revoke', to: 'tokens#revoke'
  get '/oauth/callback', to: 'authorizations#callback'
  resources :applications
  devise_for :users

  root "home#index"
end
