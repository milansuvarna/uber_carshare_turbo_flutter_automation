# frozen_string_literal: true

require 'tzinfo'

class UcsPage
  include ::Appium::Flutter::Finder

  def initialize
    @driver = AppiumConfig.driver
    initialize_elements
  end

  def initialize_elements
    @sydney_timezone = TZInfo::Timezone.get('Australia/Sydney')
    @current_date_in_sydney = Time.now.getlocal(@sydney_timezone.current_period.utc_total_offset).strftime('%d').to_i
    @time_out = 30_000
    @time_out_in_second = @time_out / 1000
    @time_out_set_frame_sync = 5000

    # by_value_key
    @email_field = element_with_value_key('emailAddressTextField')
    @password_field = element_with_value_key('passwordTextField')

    # by_type
    @login_button = element_with_type('LoginButtonView')
    @search_bar_field = element_with_type('TextFormField')
    @listview = element_with_type('SingleChildScrollView')
    @car_listing_large = element_with_type('CarListingLarge')
    @custom_scroll_view = element_with_type('CustomScrollView')

    # by_text
    @trips_tab = element_with_text('Trips')
    @login_with_email_button = element_with_text('Log in')
    @search_bar = element_with_text('City, hotel or address')
    @current_location_text = element_with_text('Current location')
    @sydney_text = element_with_text('Sydney')
    @add_dates_button = element_with_text('Add dates')
    @pickup_date = element_with_text(@current_date_in_sydney.to_s)
    @return_date = element_with_text((@current_date_in_sydney + 3).to_s)
    @confirm_dates_button = element_with_text('Confirm dates')
    @confirm_time_button = element_with_text('Confirm time')
    @nice_find_text = element_with_text('Nice find! This car is available. ')
    @checkout_button = element_with_text('Go to checkout')
    @book_now_button = element_with_text('Book now')
    @continue_button = element_with_text('Continue')
    @due_today_text = element_with_text('Due today')
    @settings_tab = element_with_text('Settings')
    @contact_details_menu = element_with_text('Contact details')
    @email_text = element_with_text('7436@example.com')
    @address_button = element_with_text('Sydney NSW')
    @find_car_near_you_text = element_with_text('Find the right car near you')
    @address_on_car_details_text = element_with_text('Sydney Central Business District, NSW')
  end

  def element_with_text(text)
    ::Appium::Flutter::Element.new(@driver, finder: (by_text text))
  end

  def element_with_type(type)
    ::Appium::Flutter::Element.new(@driver, finder: (by_type type))
  end

  def element_with_value_key(key)
    ::Appium::Flutter::Element.new(@driver, finder: (by_value_key key))
  end

  def click_element(element)
    @driver.execute_script('flutter:waitFor', element, @time_out)
    element.click
  rescue StandardError => e
    puts "Element did not appear within #{@time_out_in_second} seconds."
    raise e
  end

  def enter_text(element, text)
    @driver.execute_script('flutter:waitFor', element, @time_out)
    element.send_keys(text)
  rescue StandardError => e
    puts "Element did not appear within #{@time_out_in_second} seconds."
    raise e
  end

  def value_from_element(element)
    @driver.execute_script('flutter:waitFor', element, @time_out)
    element.text
  rescue StandardError => e
    puts "Element did not appear within #{@time_out_in_second} seconds."
    raise e
  end

  def login_with_credentials(credentials)
    enter_text(@email_field, credentials)
    enter_text(@password_field, credentials)
    click_element(@login_with_email_button)
  end

  def select_dates
    click_element(@add_dates_button)
    click_element(@pickup_date)
    click_element(@return_date)
    click_element(@confirm_dates_button)
    click_element(@confirm_time_button)
  end

  def select_a_car
    click_element(@car_listing_large)
    @driver.execute_script('flutter:scrollUntilVisible', @custom_scroll_view,
                           { item: @nice_find_text, dxScroll: 90, dyScroll: -400 })
  end

  def confirm_booking
    click_element(@checkout_button)
    click_element(@continue_button)
  end

  def book_now
    @driver.execute_script('flutter:scrollUntilVisible', @listview,
                           { item: @book_now_button, dxScroll: 90, dyScroll: -400 })
  end

  def navigate_to_sydney
    @driver.execute_script('flutter:scrollUntilVisible', @listview,
                           { item: @sydney_text, dxScroll: 90, dyScroll: -400 })
    click_element(@sydney_text)
  end

  def navigate_to_contact_details
    click_element(@settings_tab)
    click_element(@contact_details_menu)
  end

  def verify_search_page
    value_from_element(@find_car_near_you_text)
  end

  def verify_trip_summary_page
    value_from_element(@due_today_text)
  end

  def date_now
    @current_date_in_sydney.to_s
  end

  def date_three_days_later
    (@current_date_in_sydney + 3).to_s
  end

  def verify_pickup_date
    value_from_element(@pickup_date)
  end

  def verify_return_date
    value_from_element(@return_date)
  end

  def verify_address_on_search
    value_from_element(@address_button)
  end

  def verify_address_on_car_details
    value_from_element(@address_on_car_details_text)
  end

  def verify_email
    value_from_element(@email_text)
  end
end
