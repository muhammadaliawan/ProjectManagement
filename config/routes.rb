# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :clients, only: %i[index show] do
    collection do
      get :search, to: 'clients#search'
    end
  end
  resources :attachments

  resources :users, only: %i[] do
    member do
      patch 'update_password'
      get 'edit_password'
    end
  end

  namespace :admin do
    resources :clients
    resources :users do
      member do
        patch :change_user_status, to: 'users#enable_disable_user'
      end
      collection do
        get :search, to: 'users#search'
      end
    end
    resources :projects, controller: '/projects' do
      resources :payments, controller: '/payments'
      resources :comments, controller: '/comments'
      resources :time_logs, controller: '/time_logs'
    end
  end

  namespace :manager do
    resources :clients
    resources :projects, controller: '/projects' do
      resources :payments, controller: '/payments'
      resources :comments, controller: '/comments'
      resources :time_logs, controller: '/time_logs'
    end
  end

  namespace :developer do
    resources :projects, only: %i[index show], controller: '/projects' do
      resources :comments, controller: '/comments'
      resources :time_logs, controller: '/time_logs'
    end
  end
  
  get '/home', to: 'dashboard#home'
  root 'dashboard#index'

  namespace :api do
    namespace :v1 do
      resources :users
      resources :clients
      resources :projects do
        resources :payments
        resources :time_logs
        resources :attachments
      end
    end
  end

  get '*no_route_matches', to: redirect('404')
end
