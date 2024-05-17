# frozen_string_literal: true

require 'tzinfo'

# Base page class to handle common page operations
class BasePage
  include ::Appium::Flutter::Finder

  TIMEOUT = 50_000

  def initialize
    @driver = AppiumConfig.driver
  end

  # Methods for finding elements by various criteria:
  def find_element(element_type, element_value)
    locator = build_locator(element_type, element_value)
    ::Appium::Flutter::Element.new(@driver, finder: locator)
  end

  def find_element_by_ancestor(parent_type, parent_value, matching_type, matching_value)
    parent_locator = build_locator(parent_type, parent_value)
    matching_locator = build_locator(matching_type, matching_value)

    ancestor_locator = by_ancestor(
      serialized_finder: parent_locator,
      matching: matching_locator,
      match_root: false,
      first_match_only: false
    )

    ::Appium::Flutter::Element.new(@driver, finder: ancestor_locator)
  end

  def find_element_by_descendant(finder_type, finder_value, matching_type, matching_value)
    finder_locator = build_locator(finder_type, finder_value)
    matching_locator = build_locator(matching_type, matching_value)

    descendant_locator = by_descendant(
      serialized_finder: finder_locator,
      matching: matching_locator,
      match_root: false,
      first_match_only: false
    )

    ::Appium::Flutter::Element.new(@driver, finder: descendant_locator)
  end

  def build_locator(type, value)
    case type
    when :by_type
      by_type(value)
    when :by_text
      by_text(value)
    when :by_value_key
      by_value_key(value)
    else
      raise ArgumentError, "Invalid element type: #{type}"
    end
  end

  def wait_for_element(element_type)
    @driver.execute_script('flutter:waitFor', element_type, TIMEOUT)
  end

  def wait_for_element_absent(element_type)
    @driver.execute_script('flutter:waitForAbsent', element_type, TIMEOUT)
  end

  def wait_for_element_clickable(element_type)
    @driver.execute_script('flutter:waitForTappable', element_type, TIMEOUT)
  end

  def handle_element_not_visible(element_value, error)
    error_message = "#{element_value} is not visible: #{error.message}"
    puts error_message
    raise ArgumentError, error_message
  end

  # Methods for verifying element visibility:
  def verify_element_visible(element_type, element_value)
    wait_for_element(find_element(element_type, element_value))
  rescue StandardError => e
    handle_element_not_visible(element_value, e)
  end

  def verify_ancestor_element_visible(finder_type, finder_value, matching_type, matching_value)
    wait_for_element(find_element_by_ancestor(finder_type, finder_value, matching_type, matching_value))
  rescue StandardError => e
    handle_element_not_visible(matching_value, e)
  end

  def verify_descendant_element_visible(finder_type, finder_value, matching_type, matching_value)
    wait_for_element(find_element_by_descendant(finder_type, finder_value, matching_type, matching_value))
  rescue StandardError => e
    handle_element_not_visible(matching_value, e)
  end

  def verify_element_not_visible(element_type, element_value)
    wait_for_element_absent(find_element(element_type, element_value))
  rescue StandardError => e
    log_error("#{element_value} is still visible: #{e.message}")
    raise StandardError
  end

  # Methods for clicking and entering text:
  def enter_text(element_type, element_value, text)
    wait_for_element(find_element(element_type, element_value))
    find_element(element_type, element_value).send_keys(text)
  rescue StandardError => e
    handle_element_not_visible(element_value, e)
  end

  def click_element(element_type, element_value)
    wait_for_element_clickable(find_element(element_type, element_value))
    find_element(element_type, element_value).click
  rescue StandardError => e
    handle_element_not_visible(element_value, e)
  end

  def click_element_by_ancestor(parent_type, parent_value, matching_type, matching_value)
    wait_for_element(find_element_by_ancestor(parent_type, parent_value, matching_type, matching_value))
    find_element_by_ancestor(parent_type, parent_value, matching_type, matching_value).click
  rescue StandardError => e
    handle_element_not_visible(matching_value, e)
  end

  def click_element_by_descendant(finder_type, finder_value, matching_type, matching_value)
    wait_for_element(find_element_by_descendant(finder_type, finder_value, matching_type, matching_value))
    find_element_by_descendant(finder_type, finder_value, matching_type, matching_value).click
  rescue StandardError => e
    handle_element_not_visible(matching_value, e)
  end

  # Methods for scrolling and retrieving values:
  def scroll_down_to_element(listview, element_type, element_value)
    @driver.execute_script(
      'flutter:scrollUntilVisible',
      find_element(:by_type, listview),
      {
        item: find_element(element_type, element_value), dxScroll: 90, dyScroll: -400
      }
    )
  rescue StandardError => e
    handle_element_not_visible(element_value, e)
  end

  def get_value(element_type, element_value)
    wait_for_element(find_element(element_type, element_value))
    find_element(element_type, element_value).text
  rescue StandardError => e
    handle_element_not_visible(element_value, e)
  end

  def get_value_from_descendant_element(finder_type, finder_value, matching_type, matching_value)
    wait_for_element(find_element_by_descendant(finder_type, finder_value, matching_type, matching_value))
    find_element_by_descendant(finder_type, finder_value, matching_type, matching_value).text
  rescue StandardError => e
    handle_element_not_visible(matching_value, e)
  end

  def sydney_date_today
    TZInfo::Timezone.get('Australia/Sydney').now.to_date
  end
end
