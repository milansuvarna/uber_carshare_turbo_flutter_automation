# frozen_string_literal: true

require_relative '../pages/base_page'
require_relative '../pages/locators/login_page_locators'

# Represents the login page of the application
class LoginPage < BasePage
  include LoginPageLocators

  def login_sheet_title
    get_value(:by_text, LOGIN_SHEET_TITLE)
  end

  def login_with_credentials(email, password)
    enter_text(:by_value_key, EMAIL_FIELD, email)
    enter_text(:by_value_key, PASSWORD_FIELD, password)
    click_element(:by_text, LOGIN_BUTTON)
    begin
      enter_text(:by_type, OTP_CODE_FIELD, 123)
      click_element(:by_text, VERIFY_AND_LOGIN_TEXT)
    rescue StandardError
      puts 'Verification page is not displayed'
    end
  end

  def verify_login_sheet_disappeared
    verify_element_not_visible(:by_text, LOGIN_SHEET_TITLE)
  end
end
