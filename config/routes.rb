RaidIt::Application.routes.draw do

  resources :raids

  resources :characters do
    member do
      get :associate
    end
  end

  devise_for :users

  root :to => "calendar#show"

end
