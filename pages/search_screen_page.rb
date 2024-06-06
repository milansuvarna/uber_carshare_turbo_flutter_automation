# frozen_string_literal: true

require_relative '../pages/base_page'
require_relative '../pages/locators/search_screen_page_locators'

# Represents the listing page of the application
class SearchScreenPage < BasePage
  include SearchScreenPageLocators

  def verify_search_screen_page
    verify_ancestor_element_visible(:by_text, PRICE_FILTER_TEXT, :by_type, APP_CHIP)
    verify_ancestor_element_visible(:by_text, CAR_TYPE_FILTER_TEXT, :by_type, APP_CHIP)
    verify_ancestor_element_visible(:by_text, FEATURES_FILTER_TEXT, :by_type, APP_CHIP)
    verify_ancestor_element_visible(:by_text, SAFETY_AND_TECH_FILTER_TEXT, :by_type, APP_CHIP)
    verify_element_visible(:by_type, VEHICLE_IMAGE)
    verify_element_visible(:by_text, INSTANT_KEYS_TEXT) || verify_element_visible(:by_text, KEY_HANDOVER_TEXT)
    verify_element_visible(:by_value_key, LIKE_ICON)
    verify_element_visible(:by_value_key, LIKE_BUTTON)
    verify_element_visible(:by_text, MAP_ICON)
    scroll_down_to_element(SEARCH_SCREEN_PAGE_SCROLL_VIEW, :by_value_key, REFUEL_APP_BANNER)
    verify_element_visible(:by_value_key, VEHICLE_PROTECTION_APP_BANNER)
    verify_element_visible(:by_value_key, REFUEL_APP_BANNER)
  end

  def vehicle_name(vehicle_name)
    get_value(:by_text, vehicle_name)
  end

  def vehicle_address(vehicle_address)
    get_value(:by_text, vehicle_address)
  end

  def select_dates
    click_element_by_ancestor(:by_type, APP_CHIP, :by_text, 'Add dates')
  end

  def click_first_result
    click_element(:by_value_key, FIRST_RESULT_SEARCH_SCREEN_PAGE)
  end
end
