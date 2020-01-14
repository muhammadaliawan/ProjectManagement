Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects

  resources :users

  concern :shared_action do
    resources :users
    resources :projects
  end

  namespace :admin do
    resources :users do
      collection do
        get 'clients', to: 'users#clients'
      end
      member do
        patch :change_user_status, to: 'users#enable_disable_user' 
      end
    end
    resources :projects 
  end

  namespace :manager do
    concerns :shared_action
  end  

  namespace :developer do
    concerns :shared_action
  end

  root 'welcome#index'
end
