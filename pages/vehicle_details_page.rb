# frozen_string_literal: true

require_relative '../pages/base_page'
require_relative '../pages/locators/vehicle_details_page_locators'

# Represents the vehicle details page of the application
class VehicleDetailsPage < BasePage
  include VehicleDetailsPageLocators

  def verify_element_vehicle_details_page
    verify_element_visible(:by_value_key, GO_BACK_ICON_KEY)
    verify_element_visible(:by_value_key, SHARE_ICON_KEY)
    verify_element_visible(:by_value_key, CAR_PROFILE_NAME_KEY)
    verify_element_visible(:by_value_key, CAR_PROFILE_LOCATION_KEY)
    scroll_down_to_element(CAR_DETAILS_PAGE_SCROLL_VIEW, :by_text, CAR_PROFILE_FEATURES_LABEL)
    verify_element_visible(:by_text, CAR_PROFILE_FEATURES_LABEL)
    scroll_down_to_element(CAR_DETAILS_PAGE_SCROLL_VIEW, :by_text, CAR_PROFILE_DAMAGE_AND_LOSS_TEXT)
    verify_element_visible(:by_text, CAR_PROFILE_DAMAGE_AND_LOSS_TEXT)
    verify_element_visible(:by_text, CAR_PROFILE_COVERED_FOR_FIRE_TEXT)
    verify_element_visible(:by_text, CAR_PROFILE_ROAD_SIDE_ASSISTANCE_TEXT)
    verify_element_visible(:by_text, CAR_PROFILE_EXCESS_CLAIM_TEXT)
    scroll_down_to_element(CAR_DETAILS_PAGE_SCROLL_VIEW, :by_text, CAR_PROFILE_CAR_RULE_TEXT)
    verify_element_visible(:by_text, CAR_PROFILE_CAR_RULE_TEXT)
    verify_element_visible(:by_text, CAR_PROFILE_PIKCUP_RULE)
    verify_element_visible(:by_text, CAR_PROFILE_MIN_AGE_RULE)
    verify_element_visible(:by_text, CAR_PROFILE_NO_SMOKING_RULE)
    verify_element_visible(:by_text, CAR_PROFILE_NO_PETS_RULE)
    scroll_down_to_element(CAR_DETAILS_PAGE_SCROLL_VIEW, :by_text, CAR_PROFILE_TRIP_DATE_LABEL)
    verify_element_visible(:by_text, CAR_PROFILE_TRIP_DATE_LABEL)
    scroll_down_to_element(CAR_DETAILS_PAGE_SCROLL_VIEW, :by_value_key, CAR_PROFILE_REVIEW_ICON_KEY)
    verify_element_visible(:by_value_key, CAR_PROFILE_REVIEW_ICON_KEY)
  end
end
