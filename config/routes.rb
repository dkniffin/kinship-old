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

  get 'statistics', to: 'stats#show'
  get 'stats/gender_distribution', to: 'stats#gender_distribution'
  get 'stats/average_lifespan_by_century', to: 'stats#average_lifespan_by_century'
  get 'stats/name_popularity', to: 'stats#name_popularity'

  get "about",  to: 'static_pages#about'
  get 'help', to: 'help#new'
end
