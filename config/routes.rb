Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects

  resources :users

  patch 'update_password', to: 'users#update_password'
  get 'edit_password', to: 'users#edit_password'

  concern :shared_action do
    resources :users
    resources :projects
  end

  namespace :admin do
    resources :users do
      collection do
        get 'clients', to: 'users#clients'
        get :new_client, to: 'users#new_client'
        post :create_client, to: 'users#create_client'
      end

      member do
        get :show_client, to: 'users#show_client'
        get :edit_client, to: 'users#edit_client'
        patch :update_client, to: 'users#update_client'
        delete :destroy_client, to: 'users#destroy_client'

        patch :change_user_status, to: 'users#enable_disable_user' 
      end
    end
    resources :projects 
  end

  namespace :manager do
    resources :users do
      collection do
        get 'clients', to: 'users#clients'
      end
    end
  end  

  namespace :developer do
    concerns :shared_action
  end

  root 'welcome#index'
end
