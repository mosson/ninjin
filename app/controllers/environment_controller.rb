class EnvironmentController < ApplicationController
	def index
		# @backtrace   = params[:backtrace]
		# @environment = params[:environment]
		# @status_code = params[:status_code]	
		# @date_from   = params[:date_from]
		# @date_to     = params[:date_to]
		# @closed      = params[:closed]
		# @open      	 = params[:open]
		# @ip_address	 = params[:ip_address]
		@log_env		 = Log.where(:environment => @environment)

		@logs = @log_env

		respond_to do |format|
			format.html # app/views/environment/index.html.erb

		end
		
	end


	def result
		render :text => "result"
	end
end
# class Paginate
# 	def pages max_page, per_page, page_id
		
# 		per_page 	  = [max_page, per_page].min
# 		page_id 	  = page_id.to_i		
# 		center_page = (per_page/2.to_f).floor

# 		if page_id < center_page + 1
# 			from = 0
# 			to   = per_page

# 		elsif page_id > max_page - center_page
# 			from = max_page - per_page
# 			to = max_page	

# 		else			
# 			if per_page/2 == 0
# 				from = page_id - center_page
# 				to   = page_id + center_page
# 			else
			
# 				if page_id - center_page - 1 < 0
# 					from = 0
# 					to   = page_id + center_page + 1
# 				else
# 					from = page_id - center_page - 1
# 					to   = page_id + center_page
# 				end
				
# 			end			
# 		end

# 		{:from => from, :to => to}

# end
