Kinship::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Root
  root 'static_pages#home'

  # "Static" Pages
  get "static_pages/home"
  match '/home',   to: 'static_pages#home', via: 'get'

  # Request an account, Signin, Signout
  match '/signup', to: 'users#new',         via: 'get'
  match '/signin', to: 'sessions#new',      via: 'get'
  match '/signout', to: 'sessions#destroy',  via: 'delete'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  # Admin
  match '/admin', to: 'admin#home', via: 'get'
  get "admin/home"
  get "admin/look_and_feel"
  get "admin/privacy"
  get "admin/users"
  get "admin/logs"
end
