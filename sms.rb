require 'nokogiri'
require 'rake'
require 'time'

all = []

file_list = FileList['*.xml']
text_nodes = file_list.map {
	|f|
	file = Nokogiri::XML(File.read(f))
	smses = file.css('smses')
	all.push(*smses[0].css("sms[address*='5919']"))

}

ENV['TZ'] = 'US/Eastern'

all.map { 
	|message|
	body = message['body']
	timestamp = Time.at(message['date'].to_i/1000)
	name = message['type'] == "1" ? "Morgan" : "Preston"
	
	print ("%s: %s: %s" % [timestamp.strftime('%A, %B %e, %Y @ %l:%M %p %Z'), name, body])
	print "\n"

}
