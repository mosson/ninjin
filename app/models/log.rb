class Log < ActiveRecord::Base
	attr_accessible :entry, :timestamp, :environment, :error_status, :github_issued, :closed, :updated, :ip_address
	default_scope { order("timestamp DESC") }
	scope :github, where(:github_issued => true)

  def self.envs(params)
    where(:environment => params)
  end
end
