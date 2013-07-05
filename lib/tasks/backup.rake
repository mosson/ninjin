require './lib/log-worker/main'

# to-do:
# backupクラス、retrieveモジュールとreportモジュールを作る。
# 配下の細かいタスクはメソッドで定義。
path = PathFactory.new.tmp_path
path_to_report = PathFactory.new.report_path

namespace :backup do
	desc "Run setting to launch backup tasks"
	task :launch do
		Backup.new.launch
	end

	namespace :remote do

		### Retrieve
		desc "Retrieve logs from remote machine"
		task :retrieve => ["fetch", "organize"] do
			puts "Successfully finished retrieving logs."
		end

		desc "Fetch log files from remote machine"
		task :fetch do
			Backup.new.fetch_files(path, path_to_report)
		end

		desc "Organize files"
		task :organize do
			Backup.new.organize_files(path, path_to_report)
		end

		### Report
		desc "Export error log reports"
		task :report => ["validate"] do
			puts "Successfully finished exporting reports."			
		end

		desc "Validate time to JST, extract errors from logs"
		task :validate do
			usage = ENV["template"]
			Backup.new.validate_data(path, usage)
		end

	end
end