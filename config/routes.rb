LogViewerApp::Application.routes.draw do
  
  match ':controller(/:action(/:id))(.:format)'

  resources :environment

  # match '/login' => 'sessions#new', via: :get
  # match '/login' => 'sessions#create', via: :post
  # match '/logout' => 'sessions#destroy', via: :delete
end
