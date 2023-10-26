Rails.application.routes.draw do
  root 'static_pages#home'

  devise_for :employees

  resources :vacations, except: %i[edit destroy]
  resources :employees, only: [:show]
end
