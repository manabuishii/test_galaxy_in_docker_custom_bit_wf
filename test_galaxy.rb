
require 'selenium-webdriver'

driver = Selenium::WebDriver.for(:firefox)
driver.get(ARGV[0])
puts "webdriver title on google.com : #{driver.title}"
driver.close
