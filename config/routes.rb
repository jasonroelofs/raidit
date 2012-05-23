Raidit::Application.routes.draw do
  root :to => 'home#index'

  match "/login", :to => "sessions#new", :as => "login"
end
