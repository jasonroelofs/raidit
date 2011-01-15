RaidIt::Application.routes.draw do

  resources :raids do
    member do
      put :enqueue
      get :update_queue
      get :add_note
    end
  end

  resources :characters do
    collection do
      get :search
    end

    member do
      get :associate
      get :unassociate

      get :make_main
    end
  end

  match "loot", :to => "loot#show"
  match "loot/history/:name", :to => "loot#history", :as => :loot_history

  devise_for :users

  match "admin", :to => "admin#index"
  match "admin/users/:id/edit", :to => "admin#edit_user", :as => :admin_edit_user

  match "admin/raids", :to => "admin#raids"
  match "admin/logs/:id", :to => "admin#logs", :as => :admin_logs
  match "admin/api", :to => "admin#api"
  match "admin/loot", :to => "admin#loot"

  match "api/token", :to => "api#token"

  root :to => "calendar#show"

end
