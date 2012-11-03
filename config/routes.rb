Raidit::Application.routes.draw do
  root :to => 'home#index'

  resources :characters do
    member do
      put :make_main
    end
  end

  resources :users
  resources :user_permissions

  resources :sessions
  resource :profile, :controller => :profile

  resources :raids do
    resources :signups
  end

  resources :guilds do
    member do
      get :make_current
    end
  end

  match "/signups/:id/:command", :to => "signups#update", :as => "update_signup"

  match "/login", :to => "sessions#new", :as => "login"
  match "/logout", :to => "sessions#destroy", :as => "logout"
end
