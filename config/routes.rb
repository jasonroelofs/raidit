Raidit::Application.routes.draw do
  root :to => 'home#index'

  resources :characters
  resources :sessions
  resource :profile, :controller => :profile

  resources :raids do
    resources :signups
  end

  match "/signups/:id/:command", :to => "signups#update", :as => "update_signup"

  match "/login", :to => "sessions#new", :as => "login"
  match "/logout", :to => "sessions#destroy", :as => "logout"
end
