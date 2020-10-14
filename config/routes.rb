Rails.application.routes.draw do
  root 'tasks#index'

  resources :tasks
  resources :users, only: [:new, :create, :show]
  namespace :admin do
    resources :users, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :labels, only: [:new, :create, :destroy]
  
end
