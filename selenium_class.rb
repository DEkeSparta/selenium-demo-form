require "selenium-webdriver"

class SeleniumQAToolsForm
  PRACTICE_FORM_URL = "http://toolsqa.com/automation-practice-form"
  FIRST_NAME_FIELD_NAME = "firstname"
  LAST_NAME_FIELD_NAME = "lastname"
  PARTIAL_LINK_TEST_TEXT = "Partial Link"
  LINK_TEST_TEXT = "Link Test"
  FEMALE_RADIO_ID= "sex-1"
  FIVE_YEARS_RADIO_ID = "exp-4"
  DATEPICKER_ID = "datepicker"
  MANUAL_TESTER_ID = "profession-0"
  AUTO_TESTER_ID = "profession-1"
  QTP_TOOL_ID = "tool-0"
  IDE_TOOL_ID = "tool-1"
  WEBDRIVER_TOOL_ID = "tool-2"
  CONTINENTS_ID = "continents"
  COMMANDS_ID = "selenium_commands"
  SUBMIT_ID = "submit"

  def initialize
    @chrome_driver = Selenium::WebDriver.for(:chrome)
  end

  def visit_practice_form
    @chrome_driver.get(PRACTICE_FORM_URL)
  end

  # ==============================

  def get_first_name_field
    @chrome_driver.find_element(:name, FIRST_NAME_FIELD_NAME)
  end

  def fill_in_first_name_field first_name
    get_first_name_field.send_keys first_name
  end

  def get_first_name_field_value
    get_first_name_field["value"]
  end

  # ==============================

  def get_last_name_field
    @chrome_driver.find_element(:name, LAST_NAME_FIELD_NAME)
  end

  def fill_in_last_name_field last_name
    get_last_name_field.send_keys last_name
  end

  def get_last_name_field_value
    get_last_name_field["value"]
  end

  # ==============================

  def get_partial_link_test
    @chrome_driver.find_element(:partial_link_text, PARTIAL_LINK_TEST_TEXT)
  end

  def click_partial_link_test
    get_partial_link_test.click
  end

  def check_partial_link_url
    @chrome_driver.current_url
  end

  # ==============================

  def get_link_test
    @chrome_driver.find_element(:link_text, LINK_TEST_TEXT)
  end

  def click_link_test
    get_link_test.click
  end

  def check_link_url
    @chrome_driver.current_url
  end

  # ==============================

  def return_to_prev_page
    @chrome_driver.navigate.back
  end

  # ==============================

  def get_female_radio
    @chrome_driver.find_element(:id, FEMALE_RADIO_ID)
  end

  def click_female_radio
     get_female_radio.click
  end

  def check_female_radio
    get_female_radio.selected?
  end

  # ==============================

  def get_five_years_radio
    @chrome_driver.find_element(:id, FIVE_YEARS_RADIO_ID)
  end

  def click_five_years_radio
    get_five_years_radio.click
  end

  def check_five_years_radio
    get_five_years_radio.selected?
  end

  # ==============================

  def get_date_picker
    @chrome_driver.find_element(:id, DATEPICKER_ID)
  end

  def fill_date_picker
    get_date_picker.send_keys Date.today
  end

  def check_date_picker
    get_date_picker["value"]
  end

  # ==============================

  def get_manual_tester_checkbox
    @chrome_driver.find_element(:id, MANUAL_TESTER_ID)
  end

  def get_automation_tester_checkbox
    @chrome_driver.find_element(:id, AUTO_TESTER_ID)
  end

  def click_tester_checkboxes
    get_manual_tester_checkbox.click
    get_automation_tester_checkbox.click
  end

  def check_manual_tester_checkbox
    get_manual_tester_checkbox.selected?
  end

  def check_automation_tester_checkbox
    get_automation_tester_checkbox.selected?
  end

  # ==============================

  def get_qtp_tool_checkbox
    @chrome_driver.find_element(:id, QTP_TOOL_ID)
  end

  def get_ide_tool_checkbox
    @chrome_driver.find_element(:id, IDE_TOOL_ID)
  end

  def get_webdriver_tool_checkbox
    @chrome_driver.find_element(:id, WEBDRIVER_TOOL_ID)
  end

  def click_tool_checkboxes
    get_qtp_tool_checkbox.click
    get_ide_tool_checkbox.click
    get_webdriver_tool_checkbox.click
  end

  def check_qtp_tool_checkbox
    get_qtp_tool_checkbox.selected?
  end

  def check_ide_tool_checkbox
    get_ide_tool_checkbox.selected?
  end

  def check_webdriver_tool_checkbox
    get_webdriver_tool_checkbox.selected?
  end

  # ==============================

  def get_continents_dropdown
    @chrome_driver.find_element(:id, CONTINENTS_ID)
  end

  def click_australia_dropdown_option
    conts = get_continents_dropdown
    options = Selenium::WebDriver::Support::Select.new(conts)
    options.select_by(:text, "Australia")
  end

  def check_australia_dropdown_option
     Selenium::WebDriver::Support::Select.new(get_continents_dropdown).first_selected_option.text
  end

  # ==============================

  def get_commands_menu
    @chrome_driver.find_element(:id, COMMANDS_ID)
  end

  def click_wait_menu_option
    commands = get_commands_menu
    options = Selenium::WebDriver::Support::Select.new(commands)
    options.select_by(:text, "Wait Commands")
  end

  def check_wait_menu_option
     Selenium::WebDriver::Support::Select.new(get_commands_menu).first_selected_option.text
  end

  # ==============================

  def get_submit_button
    @chrome_driver.find_element(:id, SUBMIT_ID)
  end

  def click_submit_button
    get_submit_button.click
  end

  def check_submitted_url_parameters
    url = @chrome_driver.current_url
    parse_search_url url
  end

  def are_submit_params_equal_to? expected_params
    submit_params = check_submitted_url_parameters

    if submit_params.length != expected_params.length
      return false
    end

    expected_params.each do |key, val|
      if val != submit_params[key]
        return false
      end
    end

    return true
  end

  def parse_search_url url
    params = {}
    param_string = url[(url.index("/?") + 2)..-1]
    arr = param_string.split "&"

    arr2d = arr.map {|val| val.split "="}
    arr2d.each do |val|
      if params[val[0]] == nil
        params[val[0]] = val[1]
      elsif params[val[0]].class != Array
        x = params[val[0]]
        params[val[0]] = [x,val[1]]
      else
        params[val[0]].push val[1]
      end
    end
    return params
  end

end
