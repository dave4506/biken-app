Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => :registrations }
  root 'static_pages#home'
  resources :users, only: [:show, :index]
  resources :rides, only: [:show,:index,:new,:create,:destroy,:edit]
  resources :relationships, only: [:create, :destroy]
  resources :users do
    collection do
      patch 'setAdmin', :action => :setAdmin
    end
  end
end
