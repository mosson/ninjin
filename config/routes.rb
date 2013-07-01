LogViewerApp::Application.routes.draw do

	match '/:environment',   					:to => 'log#index', 					as: 'environment' do
		get '/:environment',   					:to => 'log#index', 					as: 'environment#index'
	end


	post :check,										:to => 'log#check', 				  as: 'check_close'
	get :check, 										:to => 'log#check', 					as: 'check_close'
	
	get '/:environment/closed', 			:to => 'log#index',        		as: 'close'
	post '/:environment/closed', 			:to => 'log#index', 					as: 'close'

	get '/:environment/open', 	  		:to => 'log#index', 					as: 'open'
	post '/:environment/open', 	  		:to => 'log#index', 					as: 'open'

	match '/:environment/:invalid', 	:to => 'log#invalid',					as: 'redirect'

	

end
