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
    # Get the current date in the Australia/Sydney timezone
    start_date = sydney_date_today
    next_day = start_date + 1

    # Determine if tomorrow is in the same month, else set it to the first day of the next month
    end_date = if next_day.month == start_date.month
                 next_day
               else
                 Date.new(next_day.year, next_day.month, 1)
               end

    click_element(:by_text, start_date.day)
    click_element(:by_text, end_date.day)
    click_element(:by_text, CONFIRM_DATES_TEXT)
  end

  def select_default_time
    verify_element_visible(:by_text, WHAT_TIME_SUITS_YOU_TEXT)
    click_element(:by_text, CONFIRM_TIME_TEXT)
  end
end
