require 'selenium-webdriver'

username="admin@galaxy.org"
password="admin"

client = Selenium::WebDriver::Remote::Http::Default.new
client.timeout = 120
puts "Connect to #{ARGV[0]}"

driver = Selenium::WebDriver.for :firefox, :http_client => client
#
count=0
driver.get(ARGV[0])
puts "webdriver title on google.com : #{driver.title}"
driver.save_screenshot("/work/galaxy-#{count}.png")

#
element = driver.find_element(:id, 'user')
user=element.find_elements(:xpath, "//a[contains(@title, 'Account registration or login')]")
user[0].click

count=count+1
driver.save_screenshot("/work/galaxy-#{count}.png")
#
userlogin=element.find_elements(:xpath, "//a[contains(@href, '/user/login')]")
userlogin[0].click


count=count+1
driver.save_screenshot("/work/galaxy-#{count}.png")
#
driver.switch_to.frame('galaxy_main')
loginform=driver.find_element(:id, 'login')
inputuser=loginform.find_elements(:xpath, "//input[contains(@name, 'login')]")[0]
inputuser.send_keys(username)
passworduser=loginform.find_elements(:xpath, "//input[contains(@name, 'password')]")[0]
passworduser.send_keys(password)

count=count+1
driver.save_screenshot("/work/galaxy-#{count}.png")

#
loginbutton=loginform.find_elements(:xpath, "//input[contains(@name, 'login_button')]")[0]
loginbutton.click
sleep(5)

count=count+1
driver.save_screenshot("/work/galaxy-#{count}.png")
#
element = driver.find_element(:id, 'user')
user=element.find_elements(:xpath, "//a[contains(@title, 'Account preferences and saved data')]")[0]
user.click
sleep(1)

count=count+1
driver.save_screenshot("/work/galaxy-#{count}.png")
#
parent=user.find_element(:xpath, "./../ul/li[1]/a")

count=count+1
driver.save_screenshot("/work/galaxy-#{count}.png")
#
p parent.text
#
driver.close
