# frozen_string_literal: true

require_relative '../spec/usc_page'
require_relative '../conf/appium_config'

describe 'UCS Test', :allure do
  let(:ucs_page) { UcsPage.new }

  it 'Booking Flow' do |e|
    e.run_step('Login with credentials') do
      ucs_page.login_with_credentials('7436')
    end

    e.run_step('Navigate to sydney') do
      expect(ucs_page.verify_search_page).to match('Find the right car near you')
      ucs_page.navigate_to_sydney
      expect(ucs_page.verify_address_on_search).to include('Sydney')
    end

    e.run_step('Select dates') do
      ucs_page.select_dates
    end

    e.run_step('Select a car') do
      ucs_page.select_a_car
      expect(ucs_page.verify_address_on_car_details).to include('Sydney')
    end

    e.run_step('Confirm booking') do
      ucs_page.confirm_booking
      expect(ucs_page.verify_trip_summary_page).to include('Due today')
    end

    e.run_step('Book now') do
      ucs_page.book_now
    end
  end

  it 'Verfiy Email' do |e|
    e.run_step('Login with credentials') do
      ucs_page.login_with_credentials('7436')
    end

    e.run_step('Navigate to contact details') do
      ucs_page.navigate_to_contact_details
    end

    e.run_step('Validate email address') do
      expect(ucs_page.verify_email).to eq('123')
    end
  end
end
