# frozen_string_literal: true
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'test_prof/recipes/rspec/let_it_be'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end


RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Rails.application.routes.url_helpers

  config.before(:all) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:each, type: :request) do |example|
    next if response&.body.blank? || [301, 302].include?(response&.status)

    if example.metadata[:response].present? && example.metadata[:response].key?(:examples)
      example.metadata[:response][:examples] = {
        'application/json' => JSON.parse(response.body, symbolize_names: true)
      }
    end
  end

  config.after(:suite) do
    DatabaseCleaner.clean_with :truncation
  end
end
