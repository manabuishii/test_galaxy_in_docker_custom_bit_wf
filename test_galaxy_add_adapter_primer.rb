require 'selenium-webdriver'
require 'rubygems'
require 'test/unit'
require 'time'

$url = ARGV[0]

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
    # Click Admin tab
    element = driver.find_element(:id, 'admin')
    element.click
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #

    # Click Data libraries
    # Move to parent frame.
    # At this moment driver look at iframe id 'galaxy-main'
    driver.switch_to.window driver.window_handle
    element = driver.find_elements(:xpath, "//a[@href='/library_admin/browse_libraries']")[0]
    #p driver.find_element(:id, 'left')
    element.click
    sleep 4
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # Click create new data library
    driver.switch_to.frame('galaxy_main')
    element = driver.find_elements(:xpath, "//a[@href='/library_admin/create_library']")[0]
    element.click
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # input library name adapter_primer
    libraryform=driver.find_element(:name, 'library')
    libaryname=libraryform.find_elements(:xpath, "//input[contains(@name, 'name')]")[0]
    libaryname.clear()
    libaryname.send_keys('adapter_primer')

    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # Click Create button
    createbutton=libraryform.find_elements(:xpath, "//input[contains(@name, 'create_library_button')]")[0]
    createbutton.click()
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # Click Add datasets
    element = driver.find_elements(:xpath, "//ul[@class='manage-table-actions']")[0]
    element=element.find_elements(:xpath, "//a[contains(., 'Add datasets')]")[0]
    element.click
    sleep 4
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    # Select Upload option
    upload_option=driver.find_element(:name, 'upload_option')
    options=upload_option.find_elements(:tag_name => "option")

    #### Select import_to_current_history
    options.each do |g|
      if g.text == "Upload directory of files"
        g.click
        break
      end
    end
    #
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # Click File Format
    element=driver.find_elements(:xpath, "//label[contains(.,'File Format:')]/..//div[@class='form-row-input']//a")[0]
    element.click
    sleep 4
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # select import_to_current_history
    element=driver.find_elements(:xpath, "//input[@id='s2id_autogen2_search']")[0]
    element.click
    element.send_keys('fasta')
    # input fasta , there are two choice . And we want to take just 'fasta' so send arrow_down
    element.send_keys(:arrow_down)
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # send enter
    element.send_keys(:enter)
    sleep 4
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    # Select Server Directory
    upload_option=driver.find_element(:name, 'server_dir')
    options=upload_option.find_elements(:tag_name => "option")

    #### Select adapter_primer for Server Directory
    options.each do |g|
      if g.text == "adapter_primer"
        g.click
        break
      end
    end
    #
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    # Select Copy data into Galaxy?
    upload_option=driver.find_element(:name, 'link_data_only')
    options=upload_option.find_elements(:tag_name => "option")

    #### Select adapter_primer for Server Directory
    options.each do |g|
      if g.text == "Link to files without copying into Galaxy"
        g.click
        break
      end
    end
    #
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # Click Upload to library button
    submitbutton=driver.find_elements(:xpath, "//input[contains(@type, 'submit')]")[0]
    submitbutton.click
    sleep(5)

    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #datalibrary=element.find_elements(:xpath, "//a[contains(@href, '/library_admin/browse_libraries')]")
    #count=count+1
    #driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    driver.close
  end
end
