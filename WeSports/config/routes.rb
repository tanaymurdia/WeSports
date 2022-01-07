Wesports::Application.routes.draw do
  resources :games
  resources :players, only: [:show]
  get 'games/:id/join', to: 'games#join', as: :join_game
  root 'games#login'
  
  # get '/auth/google_oath2/callback', to: 'sessions#omniauth'
  get '/auth/:provider/callback', to: 'sessions#omniauth'
  get '/login', to: 'sessions#new'
  get '/quick_login/:id', to: 'sessions#quick_login', as: :quick_login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/users/:id', to: 'users#show', as: 'user'

end