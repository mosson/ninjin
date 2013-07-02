LogViewerApp::Application.routes.draw do

	resources :logs , :to => 'logs#index', :only => %w(index) do
		collection do
			get '/:environment', as: 'environment'

			post :check,	  as: 'check_close'
			get :check, 		as: 'check_close'			
		end
	end
	
	# match '/:environment/:invalid', 	:to => 'logs#invalid',					as: 'redirect'

	

end
