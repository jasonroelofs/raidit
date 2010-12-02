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
  match "admin/raids", :to => "admin#raids"
  match "admin/logs", :to => "admin#logs"
  match "admin/api", :to => "admin#api"

  root :to => "calendar#show"

end
