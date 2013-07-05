require './lib/log-worker/modules/retrieve'
require './lib/log-worker/modules/report'
require './lib/log-worker/modules/path_factory'

class Backup
	include Retrieve
	include Report
end