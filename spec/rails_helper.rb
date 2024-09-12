require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'
require 'selenium/webdriver'
require 'webdrivers'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

require 'rails-controller-testing'

RSpec.configure do |config|
  config.fixture_paths = [Rails.root.join('spec/fixtures')]
  config.use_transactional_fixtures = true

  [:controller, :view, :helper].each do |type|
    config.include Rails::Controller::Testing::TemplateAssertions, type: type
    config.include Rails::Controller::Testing::Integration, type: type
    config.include Rails::Controller::Testing::TestProcess, type: type
  end

  # Selenium setup for Capybara
  config.before(:each, type: :system) do
    driven_by :selenium_chrome_headless
  end

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
