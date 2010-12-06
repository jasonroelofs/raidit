RaidIt::Application.routes.draw do

  resources :raids do
    member do
      put :enqueue
      get :update_queue
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

  devise_for :users

  match "admin", :to => "admin#index"
  match "admin/users/:id/edit", :to => "admin#edit_user", :as => :admin_edit_user

  match "admin/raids", :to => "admin#raids"
  match "admin/logs", :to => "admin#logs"
  match "admin/api", :to => "admin#api"

  root :to => "calendar#show"

end
