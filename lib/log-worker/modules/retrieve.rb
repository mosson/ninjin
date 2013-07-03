require 'net/scp'
require 'net/ssh'

module Retrieve
	def launch
		puts "launching backup..."

		current_dir = Dir.getwd
		usages			= ["backup"]
		envs 				= ["production", "staging"]

		Dir.mkdir("#{current_dir}/backup")
		envs.each do |env|
			Dir.mkdir("#{current_dir}/backup/#{env}")
		end
	end

	def fetch_files(dir_path)
		puts "started secure copying..."
		conf = PathFactory.new.conf
		target_files = {}
		path_arr = []

		conf.each do |key, val|
			Net::SSH.start(val["path"], val["user"], {:password => val["password"]}) do |ssh|
				target_files["#{key}"] = ssh.exec!("ls #{ENV["PATH_TO_LOGS"]}").split("\n")
			end
		end

		conf.each do |key, val|
			target_files.each do |target_env, target_files|
				if target_env == key
			 		Net::SCP.start(val["path"], val["user"], {:password => val["options"]}) do |scp|
			 			target_files.each { |file|
							begin
								FileUtils.mkdir_p("#{dir_path}/#{target_env}")
								scp.download! file, "#{dir_path}/#{target_env}"							
							rescue => e
								puts e
							end
						}
		 			end
		 			puts [target_env, target_files]
			 	end
			end
		end
	end

	def organize_files(dir_path)
		puts "started gunzip and organizing files..."
		conf = PathFactory.new.conf
		pattern = /[0-9]{6}/
		conf.keys.each do |env|
			Dir::entries("#{dir_path}/#{env}").each do |file|
				system("gunzip #{dir_path}/#{env}/#{file}") if File::ftype(file) == "directory"

				if file.match(pattern)
					begin
						puts "#{dir_path}/#{env}/#{file.match(pattern)}"
						FileUtils.mv "#{dir_path}/#{env}/#{file}", "#{dir_path}/#{env}/#{file.match(pattern)}/#{file}"
					rescue Errno::ENOENT => e
						FileUtils.mkdir_p("#{dir_path}/#{env}/#{file.match(pattern)}")
						retry
					end
				end

			end
		end

	end
end
