# frozen_string_literal: true

require 'rest-client'
require 'json'

# Base API class to handle API requests
class BaseApi
  BASE_URL = 'https://staging.ubercarshare.com/'
  COOKIE_VALUE = 'ahoy_visitor=5fdd2063-a22c-48b0-8bd2-17a38e591b01'

  # Make a GET request to the specified endpoint
  def get(endpoint)
    response = RestClient.get(BASE_URL + endpoint)
    JSON.parse(response.body)
  end

  # Make a POST request to the specified endpoint with the given payload
  def post(endpoint, payload = {})
    headers = {
      'Cookie' => "_turbo_session=#{COOKIE_VALUE}"
    }
    response = RestClient.post(BASE_URL + endpoint, payload.to_json,
                               content_type: :json, accept: :json, headers:)
    JSON.parse(response.body)
  end
end
