Rails.application.routes.draw do

  devise_for :users
  root to: 'lists#index'

  resources :lists, only: [:new, :create, :index, :show, :edit, :destroy, :update]
  resources :users, only: [:show, :edit, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
