require File.expand_path('../boot', __FILE__)

require "rails"

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.time_zone = 'Melbourne'

    config.active_record.raise_in_transactional_callbacks = true

    config.autoload_paths += %W(#{config.root}/lib)

    config.action_mailer.default_url_options = { # TODO move to env with devise
      host: 'localhost',
      port: 3000
    }
  end
end
