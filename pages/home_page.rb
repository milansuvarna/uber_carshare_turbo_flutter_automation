# frozen_string_literal: true

require_relative '../pages/base_page'
require_relative '../pages/locators/home_page_locators'

# Represents the home page of the application
class HomePage < BasePage
  include HomePageLocators

  def verify_home_page
    verify_element_visible(:by_type, BANNER)
    verify_element_visible(:by_type, SEARCH_TEXT_BOX)
    verify_element_visible(:by_text, FIND_CAR_NEAR_YOU_TEXT)
    verify_element_visible(:by_text, SUV_4WDS_TEXT)
    verify_element_visible(:by_text, VANS_TEXT)
    verify_element_visible(:by_text, SMALL_CARS_TEXT)
    verify_element_visible(:by_text, PET_FRIENDLY_CARS_TEXT)
    verify_element_visible(:by_text, SEARCH_TAB)
    verify_element_visible(:by_text, SETTINGS_TAB)
    verify_element_visible(:by_text, TRIPS_TAB)
  end

  def search_location(location)
    click_element(:by_type, SEARCH_TEXT_BOX)
    enter_text(:by_type, SEARCH_TEXT_FIELD, location)
    click_element(:by_value_key, SEARCH_ICON)
    click_element(:by_type, SEARCH_RESULT)
    sleep(5)
  end
end
