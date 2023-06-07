Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api, defaults: { format: :json} do

    resource :users, only: [:create]
    get '/users/:user_name', to: 'users#show'
    
    
    resource :posts, only: [:create]
    get '/posts/:id', to: 'posts#show'
    delete '/posts/:id', to: 'posts#destroy'

    
    resource :session, only: [:create, :destroy]
    resource :ratings, only: [:create]
    
    resource :comments, only: [:create]
    delete '/comments/:id', to: 'comments#destroy'
  end
end
