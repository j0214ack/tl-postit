PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy"

  resources :posts do
    resources :comments, only: :create

    member do
      post :vote
      put :revote
    end
  end

  resources :comments, only: [] do
    member do
      post :vote
      put :revote
    end
  end

  resources :categories, except: :index
  resources :users, except: [:destroy, :index], path_name: { new: "register"}
end
