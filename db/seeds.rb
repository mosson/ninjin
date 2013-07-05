require 'csv'
require 'active_record'

data = []
files = []
current_dir = Dir.getwd
dirs = "#{current_dir}/db/seeds"
Dir::entries(dirs).each do |dir|
	if File::ftype("#{current_dir}/db/seeds/#{dir}") == "directory"
		if dir.match(/-[0-9]/)
			Dir::entries("#{current_dir}/db/seeds/#{dir}").each do |file|
				if file.match(/[0-9]{8}/)
					CSV.foreach("#{current_dir}/db/seeds/#{dir}/#{file}") { |entry|
						data << {
							:entry => entry[0],
							:occurred_at => entry[1],
							:environment => entry[2],
							:error_status => entry[3],
							:is_issued => entry[4],
							:is_closed => entry[5],
							:is_updated => Time.now,
							:ip_address => entry[6]
						}
					}					
				end
			end
		end
	end
end

puts "inputting data to database..."

data.each do |log|
	begin
		logs = Log.new(log) unless log[:entry].nil?
		logs.save unless logs.nil?
	rescue => e
		puts e
	end
end
