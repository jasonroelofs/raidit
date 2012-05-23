Raidit::Application.routes.draw do
  root :to => 'home#index'

  resources :sessions

  match "/login", :to => "sessions#new", :as => "login"
end
