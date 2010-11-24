RaidIt::Application.routes.draw do

  resources :raids do
    member do
      put :enqueue
    end
  end

  resources :characters do
    member do
      get :associate
      get :make_main
    end
  end

  devise_for :users

  root :to => "calendar#show"

end
