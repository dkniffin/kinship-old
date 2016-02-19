require 'capybara-screenshot/cucumber'

Capybara.javascript_driver = :webkit

DatabaseCleaner.strategy = :transaction
Cucumber::Rails::Database.javascript_strategy = :truncation

# Keep only the screenshots generated from the last failing test suite
Capybara::Screenshot.prune_strategy = :keep_last_run

Capybara::Webkit.configure do |config|
  config.allow_url "d3js.org"
  config.allow_url "mapbox.com"
end
