require './lib/log-worker/main'

# to-do:
# backupクラス、retrieveモジュールとreportモジュールを作る。
# 配下の細かいタスクはメソッドで定義。
path = PathFactory.new.tmp_path

namespace :backup do
	desc "Run setting to launch backup tasks"
	task :launch do
		Backup.new.launch
	end

	namespace :remote do
		desc "Retrieve logs from remote machine"
		task :retrieve => ["fetch", "organize"] do
			puts "Successfully finished retrieving logs."
		end

		desc "Fetch log files from remote machine"
		task :fetch do
			puts "fetch"
			Backup.new.fetch_files(path)
		end

		desc "Gunzip and organizing files"
		task :organize do
			puts "organize"
			Backup.new.organize_files(path)
		end

		desc "Export error log reports"
		task :report do
			### parse
			### output(strategy)
		end
	end
end
