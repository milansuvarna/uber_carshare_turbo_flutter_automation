# frozen_string_literal: true

require 'appium_flutter_finder'
require 'allure-rspec'

RSpec.configure do |config|
  config.include Appium::Flutter::Finder

  # Configure test timeouts
  config.around(:each) do |example|
    max_test_duration = 90

    Timeout.timeout(max_test_duration) do
      example.run
    end
  rescue Timeout::Error => e
    puts 'Test took too long. Closing the app...'
    raise e
  end

  # Before each test, start the Appium driver
  config.before(:each) do
    start_appium_driver
  end

  # After each test, attach a screenshot and error message to the Allure report for failed cases and timeouts
  config.after(:each, :allure) do |example|
    attach_allure_report(example) if example.exception || example.metadata[:execution_result].status == :timeout
    AppiumConfig.quit_driver
  end

  AllureRspec.configure do |c|
    c.results_directory = 'report'
    c.clean_results_directory = true
    c.logging_level = Logger::DEBUG
  end
end

def start_appium_driver
  platform = ENV['PLATFORM'] || 'android'
  AppiumConfig.start_driver(platform)
end

def attach_allure_report(example)
  screenshot_path = "report/#{example.full_description.downcase.tr(' ', '_')}.png"
  attach_screenshot(screenshot_path)
  attach_error_message(example)
end

def attach_screenshot(screenshot_path)
  AppiumConfig.driver.save_screenshot(screenshot_path)
  Allure.add_attachment(
    name: 'Screenshot',
    source: File.open(screenshot_path),
    type: Allure::ContentType::PNG,
    test_case: true
  )
end

def attach_error_message(example)
  Allure.add_attachment(
    name: 'Error Message',
    source: example.exception.message,
    type: Allure::ContentType::TXT,
    test_case: true
  )
end
