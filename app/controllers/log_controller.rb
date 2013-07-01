#coding: utf-8

class LogController < ApplicationController
	def index		
		@backtrace   = params[:backtrace]
		@status_code = params[:status_code]	
		@date_from   = params[:date_from]
		@date_to     = params[:date_to]
		@closed      = params[:is_closed]
		@open      	 = params[:is_open]
		@environment = params[:environment]
		
		@logs = Log.all

		@logs = Log.where(:environment => "production") if @environment == "production"
		@logs = Log.where(:environment => "staging") if @environment == "staging"

		@logs = Log.where(:environment => @environment, :is_closed => true) if @closed == "true"
		@logs = Log.where(:environment => @environment, :is_closed => false) if @open == "true"

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

