Kinship::Application.routes.draw do
  root 'static_pages#home'

  ActiveAdmin.routes(self)
  mount ActiveadminSettingsCached::Engine => '/admin'

  devise_for :users

  resources :people
  namespace :life_event do
    resources :births, except: [:index]
    resources :deaths, except: [:index]
    resources :marriages, except: [:index]
  end
  resources :sources

  get 'people/stats', to: 'people#stats', as: 'people_stats'

  get "about",  to: 'static_pages#about'
  get 'help', to: 'help#new'
end
