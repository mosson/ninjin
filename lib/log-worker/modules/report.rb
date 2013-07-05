require 'erb'

module Report	
	def validate_data(dir_path, usage)
		reg = RegFactory.new()

		pattern = /[0-9]{6}/
		data_arr = []

		Time::DATE_FORMATS[:timezone] = "%Y-%m-%d %H:%M:%S %z"
		Time::DATE_FORMATS[:simple] = "%d"

		puts "decorating files..."
		conf = PathFactory.new.conf
		conf.keys.each do |env|
			Dir::entries("#{dir_path}/#{env}").each do |dir|
				if dir.match(pattern)
					Dir::entries("#{dir_path}/#{env}/#{dir}").each do |file|						

						entry_sub = []
						entries = []

						if file.match(pattern)
							data = File.read("#{dir_path}/#{env}/#{dir}/#{file}")

							reg.entry(data).each do |entry|

								error_status = reg.error_status(entry.to_s).to_s
								ip_address = reg.ip_addr(entry.to_s).to_s
								occurred_at = reg.occurred_at(entry.to_s).to_s
								
								entries << [entry, occurred_at, error_status, ip_address]

								extract_errors(entry, entry_sub, occurred_at)
							end							

							decorate_data(dir_path, entry_sub, decorated = [], entries, usage)


							date = DateTime.parse(file.match(/[0-9]{8}/).to_s)
							day_before = date - 1

							formatted_date = date.to_s(:simple)
							formatted_day_before = day_before.to_s(:simple)
							
							begin
								File.write("#{Dir.getwd}/tmp/#{usage}/#{env}/#{dir}/#{formatted_day_before}-#{formatted_date}.log", decorated.join(""))
							rescue Errno::ENOENT => e
								FileUtils.mkdir_p("#{Dir.getwd}/tmp/#{usage}/#{env}/#{dir}/")
								retry
							end
							
						end
					end
				end
			end
		end
	end

	def extract_errors(entry, entry_sub, date)
		if entry.match(/Completed\s[45]/)
			
			date = DateTime.parse(date.to_s)
			validated_date = date.new_offset(9.0/24)

			entry_sub << entry.to_s.sub(date.to_s(:timezone), validated_date.to_s(:timezone))
		end
	end

	def decorate_data(dir_path, entry_sub, decorated, entries, usage)
		template =  Dir::pwd + "/lib/log-worker/templates/#{usage}_template.erb"				
			decorated << ERB.new(File.read(template)).result(binding)
	end
end

