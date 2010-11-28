RaidIt::Application.routes.draw do

  resources :raids do
    member do
      put :enqueue
      get :update_queue
    end
  end

  resources :characters do
    member do
      get :associate
      get :make_main
    end
  end

  devise_for :users

  match "admin", :to => "admin#index"

  root :to => "calendar#show"

end
