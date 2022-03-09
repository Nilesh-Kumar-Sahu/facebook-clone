Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               registrations: 'users/registrations'
             }

  root 'static_pages#home'
  get '/signup', to: 'users#new'

  resources :users do
    member do
      get :friends
    end
  end
  resources :posts
  resources :comments
  resources :friendships
  get :pending_requests, to: 'friendships#pending'
end
