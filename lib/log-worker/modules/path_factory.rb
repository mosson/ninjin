class PathFactory
	attr_accessor :conf

	def initialize
		@conf 	= YAML.load_file("./config/conf.yaml")
	end

	def tmp_path
		current_dir = Dir.getwd
		return "#{current_dir}/tmp/logs"
	end
end