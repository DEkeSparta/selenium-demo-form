require_relative "spec_helper"

describe SeleniumQAToolsForm do

  before :all do
    @form = SeleniumQAToolsForm.new
    @form.visit_practice_form
    @test_params = {
      "firstname" => "Sarah",
      "lastname" => "Fortune",
      "sex" => "Female",
      "profession" => ["Manual+Tester","Automation+Tester"],
      "photo" => nil,
      "tool" => ["QTP","Selenium+IDE","Selenium+Webdriver"],
      "continents" => "Australia",
      "selenium_commands" => "Wait+Commands",
      "submit" => nil
    }
  end

  it "should have a working partial link" do
    @form.click_partial_link_test
    expect(@form.check_partial_link_url).to eq "http://toolsqa.com/automation-practice-form/"
    @form.return_to_prev_page
  end

  it "should have a working full link" do
    @form.click_link_test
    expect(@form.check_link_url).to eq "http://toolsqa.com/automation-practice-table/"
    @form.return_to_prev_page
  end

  it "should accept a first name" do
    @form.fill_in_first_name_field "Shiela"
    expect(@form.get_first_name_field_value).to eq "Shiela"
  end

  it "should accept a last name" do
    @form.fill_in_last_name_field "Fortune"
    expect(@form.get_last_name_field_value).to eq "Fortune"
  end

  it "should have clickable sex radio buttons" do
    @form.click_female_radio
    expect(@form.check_female_radio).to be true
  end

  it "should have clickable 'years of experience' radio buttons" do
    @form.click_five_years_radio
    expect(@form.check_five_years_radio).to be true
  end

  it "should accept a date in the date form" do
    @form.fill_date_picker
    expect(@form.check_date_picker).to eq Date.today.strftime("%Y-%m-%d")
  end

  it "should have a clickable set of tester checkboxes" do
    @form.click_tester_checkboxes
    expect(@form.check_manual_tester_checkbox).to be true
    expect(@form.check_automation_tester_checkbox).to be true
  end

  it "should have a clickable set of tool checkboxes" do
    @form.click_tool_checkboxes
    expect(@form.check_qtp_tool_checkbox).to be true
    expect(@form.check_ide_tool_checkbox).to be true
    expect(@form.check_webdriver_tool_checkbox).to be true
  end

  it "should have a selectable continent from the dropdown" do
    @form.click_australia_dropdown_option
    expect(@form.check_australia_dropdown_option).to eq "Australia"
  end

  it "should have a selectable command from the menu" do
    @form.click_wait_menu_option
    expect(@form.check_wait_menu_option).to eq "Wait Commands"
  end

  it "should submit the form with the input parameters" do
    @form.click_submit_button
    expect(@form.are_submit_params_equal_to? @test_params).to be true
  end

end
