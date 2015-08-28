Kinship::Application.routes.draw do
  # Root
  root 'static_pages#home'

  ActiveAdmin.routes(self)
  mount ActiveadminSettingsCached::Engine => '/admin'

  devise_for :users

  resources :people
  get 'people/stats', to: 'people#stats', as: 'people_stats'

#home'
  get "about",  to: 'static_pages#about'

  # Help page
  get 'help', to: 'help#new'
end
