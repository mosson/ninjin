class Log < ActiveRecord::Base

	paginates_per 10

	attr_accessible :entry, :occurred_date, :environment, :error_status, :is_issued, :is_closed, :is_updated, :ip_address
	default_scope { order("occurred_date DESC") }
	scope :is_issued, where(:is_issued => true)
	scope :is_closed, where(:is_closed => true)
	scope :envs_production, where(:environment => "production")
	scope :envs_staging, where(:environment => "staging")
	scope :envs, 			where(:environment => "staging")
  
end
