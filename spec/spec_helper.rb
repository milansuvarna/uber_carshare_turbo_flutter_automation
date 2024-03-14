# frozen_string_literal: true

require 'allure-rspec'
require 'appium_flutter_finder'
require 'tzinfo'

RSpec.configure do |config|
  config.include Appium::Flutter::Finder

  # Configure test timeouts
  config.around do |example|
    max_test_duration = 60

    Timeout.timeout(max_test_duration) do
      example.run
    end
  rescue Timeout::Error => e
    puts 'Test took too long. Closing the app...'
    raise e
  end

  # Set up Appium driver before each test
  config.before do
    caps = {
      caps: {
        platformName: 'Android',
        automationName: 'flutter',
        udid: 'emulator-5554',
        deviceName: 'Android',
        autoGrantPermissions: 'true',
        app: "#{Dir.pwd}/test.apk"
      }
    }

    @core = Appium::Core.for(caps)
    @driver = @core.start_driver
    @driver.context = 'FLUTTER'
  end

  config.after(:each, :allure) do |example|
    if example.exception
      screenshot_path = "report/#{example.full_description.downcase.tr(' ', '_')}.png"
      @driver.save_screenshot(screenshot_path)

      Allure.add_attachment(
        name: 'Screenshot',
        source: File.open(screenshot_path),
        type: Allure::ContentType::PNG,
        test_case: true
      )

      Allure.add_attachment(
        name: 'Error Message',
        source: example.exception.message,
        type: Allure::ContentType::TXT,
        test_case: true
      )
    end

    @driver.quit
  end

  # Allure configuration
  AllureRspec.configure do |c|
    c.results_directory = 'report'
    c.clean_results_directory = true
    c.logging_level = Logger::DEBUG
  end
end
