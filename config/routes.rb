RaidIt::Application.routes.draw do

  resources :raids

  match "/" => "calendar#show", :as => :root

end
