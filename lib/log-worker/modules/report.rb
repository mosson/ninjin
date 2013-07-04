require 'erb'

module Report
	def validate_data(dir_path, report_path)
		pattern = /[0-9]{6}/
		data_arr = []

		Time::DATE_FORMATS[:simple] = "%Y-%m-%d %H:%M:%S %z"
		puts "decorating files..."
		conf = PathFactory.new.conf
		conf.keys.each do |env|
			Dir::entries("#{dir_path}/#{env}").each do |dir|
				if dir.match(pattern)
					Dir::entries("#{dir_path}/#{env}/#{dir}").each do |file|
						entry = []
						entry_sub = []
						decorated = []

						if file.match(pattern)
							data = File.read("#{dir_path}/#{env}/#{dir}/#{file}")

							extract_errors(data, entry, entry_sub)														

							decorate_data(dir_path, entry_sub, decorated)

							File.write("#{report_path}/#{env}/#{dir}/#{file}", decorated.join(""))

						end
					end
				end
			end
		end
	end

	def extract_errors(data, entry, entry_sub)
		data.scan(/^Started[\s\S]+?(?=^Started)/m).each do |entry|
			if entry.match(/Completed\s[45]/)

				date = entry.to_s.match(/[0-9]{4}-([0-9]{2}-?){2}\s([0-9]{2}:?){3}\s\+[0-9]{4}/)
				date = DateTime.parse(date.to_s)
				validated_date = date.new_offset(9.0/24)

				entry_sub << entry.to_s.sub(date.to_s(:simple), validated_date.to_s(:simple))
			end
		end
	end

	def decorate_data(dir_path, entry_sub, decorated)
		fname = Dir::pwd + "/lib/log-worker/template.erb"
		entry_sub.each do |data|
			decorated << ERB.new(File.read(fname)).result(binding)
		end	
	end

end

