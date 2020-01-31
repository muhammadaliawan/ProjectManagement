# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :clients, only: %i[index show]

  resources :users do
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
    end
    resources :projects, controller: '/projects' do
      resources :comments, controller: '/comments'
    end
  end

  namespace :manager do
    resources :clients
    resources :projects, controller: '/projects' do
      resources :comments, controller: '/comments'
    end
  end

  namespace :developer do
    resources :projects, only: %i[index show], controller: '/projects' do
      resources :comments, controller: '/comments'
    end
  end

  root 'dashboard#index'
end
