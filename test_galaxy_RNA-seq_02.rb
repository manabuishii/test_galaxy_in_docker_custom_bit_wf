require 'selenium-webdriver'
require 'rubygems'
require 'test/unit'
require 'time'

$url = ARGV[0]
$history_id = ARGV[1]
$history_name = ARGV[2]

class GalaxyTest < Test::Unit::TestCase
  def setup
    # create selenium objects
    #@driver = Selenium::WebDriver.for :firefox
    #@wait = Selenium::WebDriver::Wait.new :timeout => 10
  end
  def test_galaxy

    username="admin@galaxy.org"
    password="admin"

    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 120
    puts "Connect to #{$url}"

    driver = Selenium::WebDriver.for :firefox, :http_client => client
    #
    count=0
    driver.get($url)
    puts "webdriver title on galaxy : #{driver.title}"
    driver.save_screenshot("/work/galaxy-#{count}.png")

    # Check you are not admin
    begin
      admin_field=driver.find_element(:id, 'admin')
      assert( false, "fail you are already admin")
    rescue
      # you are not admin
    end
    #p driver.page_source
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
    # Input Login and Password
    driver.switch_to.frame('galaxy_main')
    loginform=driver.find_element(:id, 'login')
    inputuser=loginform.find_elements(:xpath, "//input[contains(@name, 'login')]")[0]
    inputuser.send_keys(username)
    passworduser=loginform.find_elements(:xpath, "//input[contains(@name, 'password')]")[0]
    passworduser.send_keys(password)

    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")

    # Click Login button
    loginbutton=loginform.find_elements(:xpath, "//input[contains(@name, 'login_button')]")[0]
    loginbutton.click
    sleep(5)

    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # if login is fail, next line has error
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
    #
    begin
      admin_field=driver.find_element(:id, 'admin')
    rescue
      assert false, "ADMIN required"
    end
    # Click left top logo
    element = driver.find_element(:id, 'brand')
    element.click
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # all histories
    element = driver.find_element(:id, 'history-view-multi-button')
    element.click
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    element = driver.find_element(:id, "history-column-#{$history_id}")
    switch_button_elements = element.find_elements(:xpath, ".//button[contains(., 'Switch to')]")
    current_history_elements = element.find_elements(:xpath, ".//strong[contains(., 'Current History')]")
    p "---switch_button_elements"
    p switch_button_elements
    p "---current_history_elements"
    p current_history_elements
    if switch_button_elements != nil and switch_button_elements.length > 0 then
      switch_button = switch_button_elements[0]
      switch_button.click
      sleep 2
    end
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    driver.switch_to.window driver.window_handle

    element = driver.find_element(:id, 'brand')
    element.click
    # wait new history appeared
    wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
    begin
      wait.until { driver.find_element(:xpath, "//div[@class='search-input']") }
    rescue
      assert false, "//div[@class='search-input'] is missing"
    end
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # Click All workflows
    element = driver.find_elements(:xpath, "//a[@href='/workflow/list_for_run']")[0]
    element.click
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    driver.close
  end
end
