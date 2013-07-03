class Log < ActiveRecord::Base

	attr_accessible :entry, :occurred_at, :environment, :error_status, :is_issued, :is_closed, :is_updated, :ip_address
	default_scope { order("occurred_at DESC") }
	
	scope :envs, lambda { |env|  where(:environment => env) }  
  
end
