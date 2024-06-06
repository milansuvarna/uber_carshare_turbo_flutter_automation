# frozen_string_literal: true

require_relative '../pages/base_page'
require_relative '../pages/locators/checkout_page_locators'
require_relative '../pages/locators/car_profile_page_locators'

# Represents the checkout page of the application
class CheckoutPage < BasePage
  include CheckoutPageLocators
  include CarProfilePageLocators

  def verify_checkout_page
    verify_element_visible(:by_text, CHECKOUT_BASIC_COVER_TITLE_TEXT)
    verify_element_visible(:by_text, CHECKOUT_DAMAGE_AND_LOSS_TEXT)
    verify_element_visible(:by_text, CHECKOUT_COVERED_FOR_FIRE_TEXT)
    verify_element_visible(:by_text, CHECKOUT_ROAD_SIDE_ASSISTANCE_TEXT)
    verify_element_visible(:by_text, CHECKOUT_EXCESS_CLAIM_TEXT)
    verify_element_visible(:by_text, CHECKOUT_REDUCE_EXCESS_TEXT)
    verify_element_visible(:by_text, CHECKOUT_RECOMMENDED_TEXT)
    verify_element_visible(:by_text, CHECKOUT_PAYMENT_METHOD_TEXT)
    verify_element_visible(:by_text, CHECKOUT_CHANGE_BUTTON)
    verify_element_visible(:by_text, CHECKOUT_TNC_LINK)
    verify_element_visible(:by_value_key, CHECKOUT_ADD_PREMIUM_COVER_KEY)
    verify_element_visible(:by_text, CONTINUE_WITHOUT_PREMIUM_COVER_TEXT)
  end

  def click_checkout_button
    scroll_down_to_element(CAR_DETAILS_PAGE_SCROLL_VIEW, :by_text, NICE_FIND_TEXT)
    click_element(:by_text, GO_TO_CHECKOUT_TEXT)
  end

  def confirm_booking
    click_element(:by_text, CONTINUE_WITHOUT_PREMIUM_COVER_TEXT)
    sleep 10
  end
end
