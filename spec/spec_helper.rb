require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'
require 'webmock/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  # Include Capybara
  # config.include Capybara::DSL
  # config.include Rails.application.routes.url_helpers

  config.include FactoryGirl::Syntax::Methods

  config.include Devise::TestHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller
end
