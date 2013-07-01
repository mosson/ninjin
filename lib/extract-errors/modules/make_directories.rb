module MakeDirectories
	public
	def make_directories dir_name
		dir_name.each do |dir|
			begin
				Dir.mkdir(dir)
			rescue => e
				puts e
			end
		end		
	end	
end

