# frozen_string_literal: true

require_relative '../conf/appium_config'
require_relative '../pages/api/test_setup'
require_relative '../pages/login_page'
require_relative '../pages/home_page'
require_relative '../pages/trip_date_time_page'

PASSWORD = '12345678'
ADDRESS = '55 Pyrmont Bridge Rd, Pyrmont NSW 2009, AU'

describe 'Sanity Test', :allure do
  let(:login_page) { LoginPage.new }
  let(:api) { TestSetup.new }
  let(:user) { api.create_user }
  let(:email) { user['email'] }
  let(:vehicle) { api.list_new_vehicle }
  let(:vehicle_id) { vehicle['id'] }
  let(:vehicle_name) { vehicle['name'] }
  let(:password) { PASSWORD }
  let(:home_page) { HomePage.new }
  let(:trip_date_time_page) { TripDateTimePage.new }

  it 'Verify user should be able to create a booking' do |e|
    e.run_step('Login with verified user') do
      expect(login_page.login_sheet_title).to match('Log in to Uber Carshare')
      login_page.login_with_credentials(email, password)
      login_page.verify_login_sheet_disappeared
    end

    e.run_step("Search location: #{ADDRESS}") do
      home_page.verify_home_page
      home_page.search_location(ADDRESS)
    end

    e.run_step('Select dates') do
      expect(trip_date_time_page.pickup_and_return_title).to match('Pickup and return')
      trip_date_time_page.select_dates_today_and_tomorrow
      trip_date_time_page.select_default_time
    end

  end
end
