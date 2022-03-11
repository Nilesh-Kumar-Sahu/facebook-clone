Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               registrations: 'users/registrations',
               omniauth_callbacks: 'omniauth'
             }

  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get '/users/auth/callback', to: 'omniauth#github'

  resources :users do
    member do
      get :friends
    end
  end

  resources :posts
  resources :comments

  resources :likes
  resources :friendships
  get :pending_requests, to: 'friendships#pending'

  # get '*path' => redirect('users')
  # match '*path', to: 'application#routing_error', via: %i[get post]
end
