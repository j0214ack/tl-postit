PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy"

  resources :posts do
    resources :comments, only: :create
  end
  resources :categories, except: :index
  resources :users, only: [:create, :new, :edit], path_name: { new: "register"}
end
