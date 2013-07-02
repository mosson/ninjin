require './modules/path_factory'
require './modules/make_directories'
require './modules/secure_copy'


modules = ARGV[0]

class BackupLogs
	include MakeDirectories
	include SecureCopy
end

# path_to_dir = []
backup_logs = BackupLogs.new
path_factory = PathFactory.new

begin

	eval("backup_logs.#{modules}(path_factory.backup)") if ARGV.length == 1
	raise "Please select an module" if ARGV.length == 0

rescue => e
	# print(<<-"EOF")
 #  "No such an option #{modules}"
 #  "Please check out usage in README.md"
	# EOF
	puts e
end