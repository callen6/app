App::Application.routes.draw do
  resources :users

  root 'users#home'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy', as: 'signout'
 	get 'auth/failure', to: redirect('/')
end
