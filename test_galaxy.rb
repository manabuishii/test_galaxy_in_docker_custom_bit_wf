require 'selenium-webdriver'
client = Selenium::WebDriver::Remote::Http::Default.new
client.timeout = 120
puts "Connect to #{ARGV[0]}"

driver = Selenium::WebDriver.for :firefox, :http_client => client
driver.get(ARGV[0])
puts "webdriver title on google.com : #{driver.title}"
driver.close
