RaidIt::Application.routes.draw do

  match "/" => "calendar#show", :as => :root

end
