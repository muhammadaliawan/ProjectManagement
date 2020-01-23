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
    resources :projects
  end

  namespace :manager do
    resources :clients
    resources :projects
  end

  resources :projects do
    resources :payments
  end

  root 'dashboard#index'
end
