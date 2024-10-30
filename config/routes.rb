Rails.application.routes.draw do

  scope module: :public do
    devise_for :users
    root to: 'lists#index'

    resources :lists, only: [:new, :create, :index, :show, :edit, :destroy, :update] do
      resource :favorite, only: [:create, :destroy]
      resources :list_comments, only: [:create]
    end
    resources :users, only: [:show, :edit, :index, :update, :destroy]
    get '/search', to: 'searches#search'
  end

  devise_for :admin, skip: [:registrations, :password], controllers: {sessions: 'admin/sessions'}

  namespace :admin do
    root to: "dashboards#index"
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
