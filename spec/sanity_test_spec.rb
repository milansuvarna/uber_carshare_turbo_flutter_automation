# frozen_string_literal: true

require_relative '../conf/appium_config'
require_relative '../pages/api/test_setup'
require_relative '../pages/login_page'

PASSWORD = '12345678'

describe 'Sanity Test', :allure do
  let(:login_page) { LoginPage.new }
  let(:api) { TestSetup.new }
  let(:email) { api.create_user['email'] }
  let(:password) { PASSWORD }

  it 'Verify user should be able to create a booking' do |e|
    e.run_step('Login with verified user') do
      expect(login_page.login_sheet_title).to match('Log in to Uber Carshare')
      login_page.login_with_credentials(email, password)
      login_page.verify_login_sheet_disappeared
    end
  end
end
