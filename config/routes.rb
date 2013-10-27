App::Application.routes.draw do
    resources :users

  root 'users#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  
end
