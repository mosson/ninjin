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

		conf.each do |key, val|
			Net::SSH.start(val["path"], val["user"], val["password"]) do |ssh|
				target_files["#{key}"] = ssh.exec!("ls #{ENV["PATH_TO_LOGS"]}").split("\n")
			end
		end

		conf.each do |key, val|
			Net::SCP.start(val["path"], val["user"], val["password"]) do |scp|
				target_files.each do |env, files|
					files.each { |file|
						begin
							FileUtils.mkdir_p("#{dir_path}/#{env}")							
							# to-do:
							# scpされないファイルがある	
							scp.download! file, "#{dir_path}/#{env}"
							puts file, "#{dir_path}/#{env}"							
						rescue => e						
							puts e
						end
					}
				end
			end
			return
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
