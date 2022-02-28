Rails.application.routes.draw do
  devise_for :users,
             controllers: {
    registrations: 'users/registrations'
  }
  root 'static_pages#home'
  get    '/signup',  to: 'users#new'

  resources :users
  resources :posts, only: [:create,:destroy]

end
