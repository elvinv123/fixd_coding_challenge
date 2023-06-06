Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api, defaults: { format: :json} do
    resource :users, only: [:create, :show]
    resource :session, only: [:create, :destroy]
    resource :ratings, only: [:create]
    resource :posts, only: [:show, :create, :destroy]
    resource :comments, only: [:create, :destroy]
  end
end
