RaidIt::Application.routes.draw do

  resources :raids

  devise_for :users

  root :to => "calendar#show"

end
