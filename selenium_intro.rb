require "selenium-webdriver"

chrome_driver = Selenium::WebDriver.for(:chrome)

chrome_driver.get("http://toolsqa.com/automation-practice-form")

puts chrome_driver.find_element(:name, "firstname").send_keys("Test")

sleep 3
