require 'nokogiri'
require 'date'

ENV['TZ'] = 'US/Eastern'

task :parse do
  all = FileList['*.xml'].reduce([]) do |s, f|
    file = Nokogiri::XML File.read(f)
    sms = file.css('smses').first
    s + [*sms.css("sms[address*='5919']")]
  end

  all.each do |message|
    body = message['body']
    date = message['date'].to_i
    timestamp = Time.at date / 1000, (date % 1000) * 1000
    puts "#{timestamp}: #{message['type'] == "1" ? "Morgan" : "Preston"} => #{body}"
  end
end
