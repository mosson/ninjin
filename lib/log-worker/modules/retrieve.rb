require 'net/scp'
require 'net/ssh'

module Retrieve
	def launch
		puts "launching backup..."
		conf = PathFactory.new.conf
		current_dir = Dir.getwd
		usages			= ["backup"]


		Dir.mkdir("#{current_dir}/backup")
		conf.keys.each do |env|
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
				puts "ssh successfully connected to #{key}"
				target_files["#{key}"] = ssh.exec!("ls #{ENV["PATH_TO_LOGS"]}").split("\n")
			end
		end

		conf.each do |key, val|
			target_files.each do |target_env, target_files|
				if target_env == key
					Net::SCP.start(val["path"], val["user"], {:password => val["options"]}) do |scp|
						target_files.each { |file|

							FileUtils.mkdir_p("#{dir_path}/#{target_env}")
							scp.download! file, "#{dir_path}/#{target_env}"
							Dir::entries("#{dir_path}/#{target_env}").each do |file|

								system("gunzip #{dir_path}/#{target_env}/#{file}") if File::ftype("#{dir_path}/#{target_env}/#{file}") == "file" || file.match(/.gz/)

							end
						}
					end
					puts [target_env, target_files]
				end
			end
		end
	end

	def organize_files(dir_path)
		puts "started organizing files..."
		conf = PathFactory.new.conf
		pattern = [/[0-9]{6}/, /unicorn/, /nginx/]
		
		conf.keys.each do |env|
			Dir::entries("#{dir_path}/#{env}").each do |file|
								
				FileUtils.mkdir_p("#{dir_path}/#{env}/#{file.match(pattern[0])}") unless Dir.exist?("#{dir_path}/#{env}/#{file.match(pattern[0])}")
				
				if file.match(pattern[0])
					if File.exist?("#{dir_path}/#{env}/#{file}") && !file.match(/gz/)
						system("mv #{dir_path}/#{env}/#{file} #{dir_path}/#{env}/#{file.match(pattern[0])}/#{file}") if file.match(/log/)						
					end
				end
			end
			Dir::entries("#{dir_path}/#{env}").each do |dir|
				Dir::entries("#{dir_path}/#{env}/#{dir}").each do |file|
					FileUtils.mkdir_p("#{dir_path}/#{env}/#{dir}/#{file.match(pattern[1])}") unless Dir.exist?("#{dir_path}/#{env}/#{dir}/#{file.match(pattern[1])}")
				
					if file.match(pattern[1])
						if File.exist?("#{dir_path}/#{env}/#{dir}/#{file}") && !file.match(/gz/)
							system("mv #{dir_path}/#{env}/#{dir}/#{file} #{dir_path}/#{env}/#{dir}/#{file.match(pattern[1])}/#{file}") if file.match(/log/)
						end
					end	
				end
			end
		end

	end
end