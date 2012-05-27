Raidit::Application.routes.draw do
  root :to => 'home#index'

  resources :characters
  resources :sessions

  match "/login", :to => "sessions#new", :as => "login"
  match "/logout", :to => "sessions#destroy", :as => "logout"
end
