Rails.application.routes.draw do
  root 'tasks#index'

  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :labels, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :labels, only: [:new, :create, :destroy]
  end
  resources :sessions, only: [:new, :create, :destroy]
end
