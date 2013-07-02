# require './lib/extract-errors/main'

namespace :backup do
	namespace :remote do		
		task :retrieve do
			desc "Retrieve logs from remote machine"
			# secure_copy
			# gunzip
			# unlink
			# make_directories
			# move_files		
		end
		task :report do
			desc "Export error log reports"
			# parse
			# output(strategy)
		end
	end
end
