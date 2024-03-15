# frozen_string_literal: true

require 'appium_lib'
require 'yaml'

# Module responsible for configuring and managing the Appium driver
module AppiumConfig
  class << self
    attr_reader :driver

    # Start the Appium driver for the specified platform
    def start_driver(platform)
      appium_config = YAML.load_file('conf/appium_capabilities.yml')[platform]
      caps = { caps: appium_config.merge }

      @core = ::Appium::Core.for(caps)
      @driver = @core.start_driver
      @driver.context = 'FLUTTER'
      self
    end

    # Quit the Appium driver if it exists
    def quit_driver
      @driver&.quit
    end
  end
end
