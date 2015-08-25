Kinship::Application.routes.draw do
  devise_for :users
  #resources :places

  match '/people/stats', to: 'people#stats', via: 'get'
  resources :people
  match '/people/new', to: 'people#new', via: 'post'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Root
  root 'static_pages#home'

  # "Static" Pages
  get "static_pages/home"
  match '/home',   to: 'static_pages#home', via: 'get'
  get "static_pages/about"
  match '/about',   to: 'static_pages#about', via: 'get'

  # Help page
  match 'help' => 'help#new', via: [:get, :post]

  # Admin
  match '/admin', to: 'admin#home', via: 'get'
  get "admin/home"

  get "admin/look_and_feel"
  match "admin/look_and_feel", to: 'admin#update_look_and_feel', via: 'post'

  get "admin/privacy"
  get "admin/users"

  get "admin/logs"
end
