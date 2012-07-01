Raidit::Application.routes.draw do
  root :to => 'home#index'

  resources :characters
  resources :sessions
  resources :raids
  resources :signups

  match "/login", :to => "sessions#new", :as => "login"
  match "/logout", :to => "sessions#destroy", :as => "logout"
end
