
require 'selenium-webdriver'

driver = Selenium::WebDriver.for(:firefox)
driver.get("http://localhost:10500")
puts "webdriver title on google.com : #{driver.title}"
driver.close
