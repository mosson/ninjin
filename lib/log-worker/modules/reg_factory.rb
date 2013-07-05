class RegFactory
	attr_accessor :value

	def error_status(value)
		value = value.match(/(?<=Completed\s)[0-9]{3}/)
	end
	
	def ip_addr(value)
		value = value.match(/([0-9]{1,3}\.?){4}(?=\sat?)/)
	end
	
	def occurred_at(value)
		value = value.match(/[0-9]{4}-([0-9]{2}-?){2}\s([0-9]{2}:?){3}\s\+[0-9]{4}/)
	end
	
	def entry(value)
		value = value.scan(/^Started[\s\S]+?(?=^Started)/m)
	end
end