LogViewerApp::Application.routes.draw do

	resources :logs , :to => 'logs#index', :only => %w(index) do
		collection do
			get '/:environment', as: 'environment'

			post :check, 				 as: 'check_closed'
			get  :check,				 as: 'check_closed'			

		end
	end
	
	

	

end
