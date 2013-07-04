#coding: utf-8

class LogsController < ApplicationController	

	def index		
		@logs = Log.scoped

		@logs = @logs.envs(@environment).page(params[:page]).per(10) unless @environment.nil?

		@logs = @logs.where(:is_closed => params[:log][:is_closed].nil?) unless params[:log].present?

		respond_to do |format|
			format.html
		end		
	end

	def invalid
	end

	def check		
	end	

end

