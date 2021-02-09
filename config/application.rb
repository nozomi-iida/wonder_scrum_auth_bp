# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WonderScrum
  # Application
  class Application < Rails::Application
    config.load_defaults 6.0
    config.api_only = true
    # 一旦Sidekiq無し
    # config.active_job.queue_adapter = :sidekiq

    # rails_admin
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Flash
    config.middleware.use Rack::MethodOverride
    config.middleware.use ActionDispatch::Session::CookieStore, { key: '_wonder_scrum_session' }

    # require
    config.autoload_paths << 'lib'

    # タイムゾーン(ruby側は東京にして, DBはUTCに)
    config.time_zone = 'Tokyo'

    # LBのIPを特定することが不可能なので無効化
    config.hosts.clear

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end

    app_host = Rails.env.test? ? 'localhost:3000' : ENV.fetch('APP_HOST')
    Rails.application.routes.default_url_options = {
      host: app_host,
      protocol: app_host.match?(/localhost/) ? 'http' : 'https'
    }
  end
end
