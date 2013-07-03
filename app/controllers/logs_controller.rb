#coding: utf-8

class LogsController < ApplicationController	

	def index		
		@environment = params[:environment]		
		@logs = Log.scoped

		@logs = @logs.envs(@environment).page(params[:page]).per(10) unless @environment.nil?

		@logs = @logs.where(:is_closed => !params[:log][:is_closed].nil?) unless params[:log].nil?

		respond_to do |format|
			format.html
		end		
	end

	def invalid		
		# redirect_to "/staging" if params[:invalid] == "staging"
		# redirect_to "/production" if params[:invalid] == "production"
	end

	def check
		
	end	

end

