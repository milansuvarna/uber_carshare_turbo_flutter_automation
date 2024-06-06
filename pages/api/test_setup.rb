# frozen_string_literal: true

require_relative 'base_api'

# Class for setting up test scenarios using API requests
class TestSetup < BaseApi
  # Creates a new user via API
  def create_user
    post('api/v2/test_setup/members?type=cypress_borrower')
  end

  # list a new vehicle via API
  def create_vehicle
    post('api/v2/test_setup/cars?type=online_vehicle')
  end
end
