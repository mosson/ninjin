require './lib/log-worker/main'

# to-do: 
# backupクラス、retrieveモジュールとreportモジュールを作る。
# 配下の細かいタスクはメソッドで定義。

namespace :backup do
	desc "Run setting to launch backup tasks"
	task :launch do
		Backup.new.launch
	end

	namespace :remote do
		desc "Retrieve logs from remote machine"
		task :retrieve do

			path = PathFactory.new.tmp_path
			### fetch_files
			### gunzip
			### unlink
			### make_directories
			### move_files

			# Backup.new.fetch_files(path)						
			Backup.new.organize_files(path)

		end

		desc "Export error log reports"
		task :report do				
			### parse
			### output(strategy)
		end
	end
end
