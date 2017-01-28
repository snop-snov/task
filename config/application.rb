require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Task
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :test_unit, fixture: false, fixture_replacement: :factory_girl
    end
  end
end
