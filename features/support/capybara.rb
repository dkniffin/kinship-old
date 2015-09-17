Capybara.javascript_driver = :webkit

DatabaseCleaner.strategy = :transaction
Cucumber::Rails::Database.javascript_strategy = :truncation

Capybara::Webkit.configure do |config|
  config.allow_url "d3js.org"
  config.allow_url "mapbox.com"
end
