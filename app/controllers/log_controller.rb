#coding: utf-8

class LogController < ApplicationController
	def index		
		@environment = params[:environment]
		
		@logs = Log.where(:environment => @environment)

		@logs = @logs.where(:is_closed => true) if params[:commit] == "CLOSED"
		@logs = @logs.where(:is_closed => false) if params[:commit] == "OPEN"

		respond_to do |format|
			format.html
		end
	end

	def invalid
		redirect_to "/staging" if params[:invalid] == "staging"
		redirect_to "/production" if params[:invalid] == "production"
	end

	def check
		@environment = params[:environment]		
		unless params[:checked_id].nil?
			# params[:checked_id].each do |id|
				Log.where(:id => params[:checked_id]).first.update_attribute(:is_closed, true)
				
				@logs = @logs.where(:environment => @environment, :closed => true)
				render :action => "index", :layout => "log"
			# end
			redirect_to "/#{params[:environment]}"
		end
	end	

end

