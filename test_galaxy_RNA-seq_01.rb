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
    p parent.text
    #
    begin
      admin_field=driver.find_element(:id, 'admin')
    rescue
      assert false, "ADMIN required"
    end
    #
    element = driver.find_element(:id, 'brand')
    element.click
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    element = driver.find_element(:id, 'history-options-button')
    element.click
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    element = driver.find_element(:id, 'history-options-button-menu')
    create_new=element.find_elements(:xpath, "//a[contains(., 'Create New')]")[0]
    create_new.click
    sleep 5
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    element = driver.find_element(:id, 'current-history-panel')
    history_title=element.find_elements(:xpath, "//div[@class='title']")[0]
    history_title.click
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    element = driver.find_element(:id, 'current-history-panel')
    history_title=element.find_elements(:xpath, "//div[@class='title']")[0]
    history_input=element.find_elements(:xpath, "//div[@class='title']/div[@class='name']/input")[0]
    # input history name
    current_time = Time.now.iso8601.to_s
    history_name = "history_"+current_time
    history_input.send_keys(history_name+"\n")

    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # check successfully new history
    element = driver.find_element(:id, 'current-history-panel')
    new_history_title=element.find_elements(:xpath, "//div[@class='title']")[0]
    inputed_new_history_title = new_history_title.text
    assert_equal(history_name, inputed_new_history_title, "history name is different expected maybe send_keys fail")
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")

    # import data library
    admin_field=driver.find_element(:id, 'admin')
    admin_field.click
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")

    # Click Data libraries
    #
    element = driver.find_elements(:xpath, "//a[@href='/library_admin/browse_libraries']")[0]
    element.click
    sleep 4
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # Click quartz_div100_rename
    driver.switch_to.frame('galaxy_main')
    element = driver.find_element(:id, "grid-table")
    element = element.find_elements(:xpath, "//a[contains(.,'quartz_div100_rename')]")[0]
    element.click
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    # Select sample 1 , ES_SRR616819_div100_1.fastq
    element = driver.find_element(:id, "library-grid")
    #element = element.find_elements(:xpath, "//a[contains(.,'ES_SRR616819_div100_1.fastq')]")[0]

    datasets=["ES_SRR616819_div100_1.fastq", "ES_SRR616820_div100_1.fastq", "ES_SRR616821_div100_1.fastq", "ES_SRR616822_div100_1.fastq", "PE_SRR616836_div100_1.fastq", "PE_SRR616837_div100_1.fastq","PE_SRR616838_div100_1.fastq","PE_SRR616839_div100_1.fastq"]
    datasets.each { |dataset|
      element.find_elements(:xpath, "//a[contains(.,'#{dataset}')]/../../input")[0].click
    }
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    action_on_selected_items=driver.find_element(:id, "action_on_selected_items")

    options=action_on_selected_items.find_elements(:tag_name => "option")

    #### Select the option "Volvo"
    options.each do |g|
      if g.text == "import_to_current_history"
      g.click
      break
      end
    end
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #
    driver.find_element(:id, "action_on_datasets_button").click
    sleep 2
    count=count+1
    driver.save_screenshot("/work/galaxy-#{count}.png")
    #

    #
    driver.close
  end
end
