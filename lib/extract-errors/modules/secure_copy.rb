module SecureCopy
	require 'rubygems'
	require 'net/scp'
	require 'net/ssh'
	require 'yaml'

	def secure_copy dir_path
		puts "started secure copying..."		
		month_now = Time.now.strftime("%Y%m")
		current_dir = "/Users/4dusers/survey-logs/daikon/backup"

		conf 	= YAML.load_file("./conf/conf.yaml")	

		target_files = {}
		
		conf.each do |key, val|
			Net::SSH.start(val["path"], val["user"], :password=>ENV["PRODUCTION_PASSWORD"]) do |ssh|
				begin
					target_files["#{key}"] = ssh.exec!("ls #{ENV["PATH_TO_LOGS"]}").split("\n")	
				rescue => e
					puts e
				end
			end
		end

		conf.each do |key, val|
			Net::SCP.start(val["path"], val["user"], :password=>ENV["PRODUCTION_PASSWORD"]) do |scp|
				target_files.each do |env, files|
					p env,files			
					files.each { |file|
						begin		
							scp.download! file, "#{current_dir}/#{env}"
							puts file, "#{current_dir}/#{env}"
						rescue => e
							puts e
						end		
					}					
				end				

			end

			return

		end

	end
end

