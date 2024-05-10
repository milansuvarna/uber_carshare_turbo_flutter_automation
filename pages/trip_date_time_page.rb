# frozen_string_literal: true

require_relative '../pages/base_page'
require_relative '../pages/locators/trip_date_time_page_locators'

# Represents the trip date time page of the application
class TripDateTimePage < BasePage
  include TripDateTimePageLocators

  def pickup_and_return_title
    get_value(:by_text, PICKUP_AND_RETURN_TEXT)
  end

  def select_dates_today_and_tomorrow
    today = Date.today
    australian_today_date = today.strftime("%d")

    tomorrow = today + 1
    if tomorrow.month != today.month
      tomorrow = Date.new(tomorrow.year, tomorrow.month, 1) # Set tomorrow to the first day of the next month
    end
    australia_tomorrow_date = tomorrow.strftime("%d")

    # Remove leading zero if present
    australia_tomorrow_date.sub!(/^0/, '') if australia_tomorrow_date.start_with?('0')

    click_element(:by_text, australian_today_date)
    click_element(:by_text, australia_tomorrow_date)
    click_element(:by_text, CONFIRM_DATES_TEXT)
  end

  def select_default_time
    verify_element_visible(:by_text,WHAT_TIME_SUITS_YOU_TEXT)
    click_element(:by_text, CONFIRM_TIME_TEXT)
  end
end
