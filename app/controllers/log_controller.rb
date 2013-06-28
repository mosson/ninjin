#coding: utf-8

class LogController < ApplicationController
	def index
		@backtrace   = params[:backtrace]
		@environment = params[:env]
		@status_code = params[:status_code]	
		@date_from   = params[:date_from]
		@date_to     = params[:date_to]
		@closed      = params[:closed]
		@open      	 = params[:open]
		@ip_address	 = params[:ip_address]
		
		@logs = Log.all

		respond_to do |format|
			format.html
		end
	end

	def view
		@logs = Log.all
		render :action => "index", :layout => "environment"				
	end
end

