require 'net/scp'
require 'net/ssh'
require './lib/log-worker/modules/reg_factory'

module Retrieve
	def launch		
		puts "launching backup..."
		conf = PathFactory.new.conf
		current_dir = Dir.getwd

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

		["#{ENV["PATH_TO_LOGS"]}", "#{ENV["PATH_TO_NGINX_LOGS"]}"].each do |path|
			conf.each do |key, val|
				Net::SSH.start(val["path"], val["user"], {:password => val["password"]}) do |ssh|
					puts "ssh successfully connected to #{key}"

					target_files["#{key}"] = ssh.exec!("ls #{path}").split("\n")
				end
			end

			conf.each do |key, val|
				target_files.each do |target_env, target_files|
					if target_env == key
						secure_copy(val, target_files, dir_path, target_env)
						puts [target_env, target_files]
					end
				end
			end
		end
	end

	def secure_copy(val, target_files, dir_path, target_env)
		Net::SCP.start(val["path"], val["user"], {:password => val["options"]}) do |scp|
			target_files.each { |file|

				unless File.exist?("#{dir_path}/#{target_env}")
					FileUtils.mkdir_p("#{dir_path}/#{target_env}") 
				end
				
				scp.download! file, "#{dir_path}/#{target_env}"
				Dir::entries("#{dir_path}/#{target_env}").each do |file|

					if File::ftype("#{dir_path}/#{target_env}/#{file}") == "file" || file.match(/.gz/)
						system("gunzip #{dir_path}/#{target_env}/#{file}")
					end

				end
			}
		end
	end

	def organize_files(dir_path)
		puts "started organizing files..."
		conf = PathFactory.new.conf
		pattern = [/[0-9]{6}/, /unicorn/, /nginx/]
		
		conf.keys.each do |env|
			path_to_env = "#{dir_path}/#{env}"
		
			Dir::entries("#{path_to_env}").each do |file|
				matched_date = file.match(pattern[0])

				unless Dir.exist?("#{path_to_env}/#{matched_date}")
					FileUtils.mkdir_p("#{path_to_env}/#{matched_date}/nginx")
					FileUtils.mkdir_p("#{path_to_env}/#{matched_date}/unicorn")
				end
				if matched_date
					if File.exist?("#{path_to_env}/#{file}") && !file.match(/gz/) && file.match(/log/)
						system("mv #{path_to_env}/#{file} #{path_to_env}/#{matched_date}/#{file}")
					end
				end
			end

			Dir::entries("#{path_to_env}").each do |dir|
				if dir.match(pattern[0])
					Dir::entries("#{path_to_env}/#{dir}").each do |file|
						
						matched_date = file.match(pattern[0])

						if file.match(pattern[1])	&& matched_date
							system("mv #{path_to_env}/#{dir}/#{file} #{path_to_env}/#{dir}/#{file.match(pattern[1])}/#{file}")

						elsif file.match(/access|error/)
							system("mv #{path_to_env}/#{dir}/#{file} #{path_to_env}/#{dir}/nginx/#{file}")
							puts " #{path_to_env}/#{dir}/nginx/"
						end
					end
				end
			end
		end
	end

end