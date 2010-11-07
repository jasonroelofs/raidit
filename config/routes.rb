RaidIt::Application.routes.draw do

  resources :raids

  root :to => "calendar#show"

end
