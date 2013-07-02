class Log < ActiveRecord::Base

	attr_accessible :entry, :occurred_date, :environment, :error_status, :is_issued, :is_closed, :is_updated, :ip_address
	default_scope { order("occurred_date DESC") }
	scope :envs, 						where(:environment => @environment)
  
end
