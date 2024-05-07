# frozen_string_literal: true

require_relative '../pages/base_page'
require_relative '../pages/locators/trip_date_time_page_locators'

# Represents the trip date time page of the application
class TripDateTimePage < BasePage
  include TripDateTimePageLocators

  def pickup_and_return_title
    get_value(:by_text, PICKUP_AND_RETURN_TEXT)
  end

  def select_dates(pickup_date, return_date)
    click_element(:by_text, pickup_date)
    click_element(:by_text, return_date)
    click_element(:by_text, CONFIRM_DATES_TEXT)
  end

  def select_default_time
    verify_element_visible(:by_text,WHAT_TIME_SUITS_YOU_TEXT)
    click_element(:by_text, CONFIRM_TIME_TEXT)
  end
end
