# frozen_string_literal: true

require_relative '../pages/base_page'
require_relative '../pages/locators/trip_summary_page_locators'

# Represents the trip summary page of the application
class TripSummaryPage < BasePage
  include TripSummaryPageLocators

  def verify_trip_summary_page
    scroll_down_to_element(TRIPS_SUMMARY_PAGE_LISTVIEW, :by_text, TRIPS_SUMMARY_DUE_TODAY_LABEL)
    get_value(:by_text, TRIPS_SUMMARY_DUE_TODAY_LABEL)
  end

  def book_now
    scroll_down_to_element(TRIPS_SUMMARY_PAGE_LISTVIEW, :by_text, TRIPS_SUMMARY_BOOK_NOW_TEXT)
    click_element(:by_text, TRIPS_SUMMARY_BOOK_NOW_TEXT)
    begin
      click_element(:by_text, TRIPS_SUMMARY_I_UNDERSTAND_AND_AGREE_TEXT)
      sleep 10
    rescue StandardError
      puts 'Consent sheet is not displayed'
    end
  end
end
