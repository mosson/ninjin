class PathFactory

	def initialize		
	end

	def backup
		if ("#{ARGV[0]}") == "make_directories"
			path_arr = []
			current_dir = Dir.getwd
			month_now = Time.now.strftime("%Y%m")

			path_arr << "#{current_dir}/backup"

			["production", "staging"].each do |env|

				path_arr << File.join(current_dir, "backup/#{env}")			
				path_arr << "#{current_dir}/backup/#{env}/#{month_now}"

				["unicorn", "nginx"].each do |server_env|
					path_arr << File.join(current_dir, "backup/#{env}/#{month_now}/#{server_env}")
				end
			end
			return path_arr
		
		elsif ("#{ARGV[0]}") == "secure_copy"		

		end		
	end


end