# frozen_string_literal: true
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'dotenv-rails'
gem 'graphql', '~> 1.11'
gem 'jwt', '~> 2.2'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 6.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'debase'
  gem 'factory_bot_rails'
  gem 'rspec', '~> 3.9'
  gem 'rspec-graphql_matchers', '~> 1.3'
  gem 'rspec-rails', '~> 4.0'
  gem 'rubocop', '~> 0.93.0'
  gem 'rubocop-rails', '~> 2.8'
  gem 'rubocop-rspec', '~> 1.44'
  gem 'ruby-debug-ide'
  gem 'database_cleaner', '~> 1.8'
  gem 'test-prof'
end

group :development do
  gem 'graphiql-rails'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
