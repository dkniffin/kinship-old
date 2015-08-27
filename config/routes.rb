Kinship::Application.routes.draw do
  # Root
  root 'static_pages#home'

  devise_for :users

  resources :people
  get 'people/stats', to: 'people#stats', as: 'people_stats'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  # "Static" Pages
  get "home",   to: 'static_pages#home'
  get "about",  to: 'static_pages#about'

  # Help page
  get 'help', to: 'help#new'

  # Admin
  get "home", to: 'admin#home'
  get "look_and_feel", to: 'admin#update_look_and_feel'

  get "privacy", to: 'admin#privacy'
  get "users", to: 'admin#users'

  get "logs", to: 'admin#logs'
end
