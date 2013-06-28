#coding: utf-8

class LogController < ApplicationController
	def index		
		@backtrace   = params[:backtrace]
		@status_code = params[:status_code]	
		@date_from   = params[:date_from]
		@date_to     = params[:date_to]
		@closed      = params[:is_closed]
		@open      	 = params[:is_open]
		@ip_address	 = params[:ip_address]
		
		@logs = Log.all

		@logs = Log.where(:environment => "production").page(params[:page]).per(10) if @environment == "production"
		@logs = Log.where(:environment => "staging").page(params[:page]).per(10) if @environment == "staging"

		respond_to do |format|
			format.html
		end
	end

	def open_or_closed
		@environment = params[:environment]

		@logs = Log.where(:environment => @environment, :is_closed => true) if params[:is_closed] == "true"
		@logs = Log.where(:environment => @environment, :is_closed => false) if params[:is_open] == "true"
		
		render :action => "index", :layout => "log"
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

