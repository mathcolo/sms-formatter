require 'nokogiri'
require 'date'
require 'gruff'

ENV['TZ'] = 'US/Eastern'

last4 = '5919'

task :parse do


  all = FileList['*.xml'].reduce([]) do |s, f|
    file = Nokogiri::XML File.read(f)
    sms = file.css('smses').first
    s + [*sms.css("sms[address*='#{last4}']")]
  end

  all.each do |message|
    body = message['body']
    date = message['date'].to_i
    timestamp = Time.at date / 1000, (date % 1000) * 1000
    puts "#{timestamp}: #{message['type'] == "1" ? "Morgan" : "Preston"} => #{body}"
  end
end

task :graph do

	all = FileList['*.xml'].reduce([]) do |s, f|
    	file = Nokogiri::XML File.read(f)
    	sms = file.css('smses').first
    	s + [*sms.css("sms[address*='#{last4}']")]
 	 end

 	 frequencies = {}

 	all.each do |message|
    	date = message['date'].to_i
    	timestamp = Time.at date / 1000, (date % 1000) * 1000
    	month = timestamp.strftime('%m-%Y')
    	if !frequencies.key?(month)
    		frequencies[month] = 1
    	else
    		frequencies[month] += 1
    	end    	
  	end

  	g = Gruff::Bar.new('1200x700')
	g.font = '/System/Library/Fonts/HiraKakuInterface-W1.otf'
	g.title = "SMS Frequency: #{last4}"
	g.x_axis_label = "Month"
	g.y_axis_label = "Frequency"
	g.hide_legend = true
  	g.data(frequencies.keys,frequencies.values)

  	labels = Hash[frequencies.keys.map.with_index { |x, i| [i, x.to_s] }]
  	adjustedLabels = {}
  	(0..labels.size).step(10) do |n|
  		adjustedLabels[n] = labels[n]
  	end
  	g.labels = adjustedLabels

  	g.minimum_value = 0
  	g.maximum_value = frequencies.values.max + 100

  	g.write('data.png')

end

