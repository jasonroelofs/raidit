RaidIt::Application.routes.draw do

  resources :raids

  resources :characters

  devise_for :users

  root :to => "calendar#show"

end
