Rails.application.routes.draw do
  root 'tasks#index'

  resources :tasks do
    member do
      patch :file_purge
    end
  end

  resources :users, only: [:new, :create, :show]
  resources :labels, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :labels, only: [:new, :create, :destroy]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :groups
  resources :groupings, only: [:create, :destroy]
end
