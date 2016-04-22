require 'selenium-webdriver'
require 'rubygems'
require 'test/unit'
require 'time'

$url = ARGV[0]
$history_id = ARGV[1]
$quantification_tool = ARGV[2]

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
    wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
    begin
      wait.until { driver.find_element(:id, "history-column-#{$history_id}") }
    rescue
      assert false, "history-column-#{$history_id} is missing"
    end

    # wait for display all histories
    element = driver.find_element(:id, "history-column-#{$history_id}")
    switch_button_elements = element.find_elements(:xpath, ".//button[contains(., 'Switch to')]")
    current_history_elements = element.find_elements(:xpath, ".//strong[contains(., 'Current History')]")
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
    # RNA-seq_02_Plotting of QC-all,corr,H-clustering and PCA) (imported from API)
    # Click RNA-seq_02_Plotting of QC-all,corr,H-clustering and PCA) (imported from API)
    driver.switch_to.frame('galaxy_main')
    element = driver.find_elements(:xpath, "//a[contains(., 'RNA-seq_02_Plotting of QC-all,corr,H-clustering and PCA)')]")[0]
    element.click
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # Get current history name
    driver.switch_to.window driver.window_handle
    element = driver.find_element(:id, 'current-history-panel')
    history_title=element.find_elements(:xpath, "//div[@class='title']")[0]
    history_name = history_title.text
    # Click Step 1
    driver.switch_to.frame('galaxy_main')
    element = driver.find_elements(:xpath, "//span[contains(.,'Step 1:')]")[0]
    element.click
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    ### open select by click editable_field
    element = driver.find_elements(:xpath, "//label[contains(.,'Supply your Current history name from top of history pain ')]/..//span[@class='editable_field']")[0]
    element.click
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # input history input name
    element = driver.find_elements(:xpath, "//label[contains(.,'Supply your Current history name from top of history pain ')]/..//span[@class='editable']/input[@type='text']")[0]
    #sleep 5

    element.clear
    element.send_keys(history_name)
    #p element.attribute('value')
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # Click Step 2
    #driver.switch_to.frame('galaxy_main')
    element_step2 = driver.find_elements(:xpath, "//span[contains(.,'Step 2:')]")[0]
    element_step2.click
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    ### open select by click editable_field
    element = driver.find_elements(:xpath, "//span[contains(.,'Step 2:')]/../..//label[contains(.,'Supply your Current history name from top of history pain')]/..//span[@class='editable_field']")[0]
    element.click
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # # input history input name
    element = driver.find_elements(:xpath, "//span[contains(.,'Step 2:')]/../..//label[contains(.,'Supply your Current history name from top of history pain ')]/..//span[@class='editable']/input[@type='text']")[0]
    element.clear
    element.send_keys(history_name)
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    # Select quatintification tool
    # Step 3 select
    #element = driver.find_elements(:xpath, "//label[contains(.,'Input Dataset [Adapter or Primer list]')]/..//select")[0]
    ### open select by click editable_field
    element = driver.find_elements(:xpath, "//span[contains(.,'Step 2:')]/../..//label[contains(.,'Chouse of used quantification tool')]/..//span[@class='editable_field']")[0]
    element.click

    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")

    #
    element = driver.find_elements(:xpath, "//span[contains(.,'Step 2:')]/../..//select")[0]
    select_list = Selenium::WebDriver::Support::Select.new(element)
    select_list.select_by(:value, $quantification_tool)
    sleep 1
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    # Step3
    # Click Step 3
    #driver.switch_to.frame('galaxy_main')
    element_step3 = driver.find_elements(:xpath, "//span[contains(.,'Step 3:')]")[0]
    element_step3.click
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    ### open select by click editable_field
    element = driver.find_elements(:xpath, "//span[contains(.,'Step 3:')]/../..//label[contains(.,'Supply your Current history name from top of history pain')]/..//span[@class='editable_field']")[0]
    element.click
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # # input history input name
    element = driver.find_elements(:xpath, "//span[contains(.,'Step 3:')]/../..//label[contains(.,'Supply your Current history name from top of history pain ')]/..//span[@class='editable']/input[@type='text']")[0]
    element.clear
    element.send_keys(history_name)
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    # Select quatintification tool
    # Step 3 select
    #element = driver.find_elements(:xpath, "//label[contains(.,'Input Dataset [Adapter or Primer list]')]/..//select")[0]
    ### open select by click editable_field
    element = driver.find_elements(:xpath, "//span[contains(.,'Step 3:')]/../..//label[contains(.,'Chouse of used quantification tool')]/..//span[@class='editable_field']")[0]
    element.click

    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")

    #
    element = driver.find_elements(:xpath, "//span[contains(.,'Step 3:')]/../..//select")[0]
    select_list = Selenium::WebDriver::Support::Select.new(element)
    select_list.select_by(:value, $quantification_tool)
    sleep 1
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    #
    # Step5
    # Click Step 5
    #driver.switch_to.frame('galaxy_main')
    element = driver.find_elements(:xpath, "//span[contains(.,'Step 5:')]")[0]
    element.click
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    element = driver.find_elements(:xpath, "//span[contains(.,'Step 5:')]/../..//label[contains(.,'Chouse of used quantification tool')]/..//span[@class='editable_field']")[0]
    element.click
    #
    element = driver.find_elements(:xpath, "//span[contains(.,'Step 5:')]/../..//select")[0]
    select_list = Selenium::WebDriver::Support::Select.new(element)
    select_list.select_by(:value, $quantification_tool)
    sleep 1
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    # Run workflow
    element = driver.find_elements(:xpath, "//input[@name='run_workflow']")[0]
    element.click
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")

    #
    driver.close
  end
end
