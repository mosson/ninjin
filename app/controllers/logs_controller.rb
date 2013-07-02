#coding: utf-8

class LogsController < ApplicationController	

	def index
		@environment = params[:environment]		
		@logs = Log.scoped
		@page = params[:page]

		@logs = @logs.where(:environment => @environment).page(@page).per(10) unless @environment.nil?


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

		@logs = Log.scoped.where(:environment => @environment, :is_closed => true)
		
		unless params[:checked_id].nil?
			# params[:checked_id].each do |id|
				Log.where(:id => params[:checked_id]).first.update_attribute(:is_closed, true)
				
				@logs = @logs.where(:environment => @environment, :is_closed => true).page(@page).per(10)
				render :action => "index", :layout => "logs"
			# end
			
		end

		# redirect_to "/#{params[:environment]}"

	end	

end

