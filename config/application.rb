require_relative 'boot'

require 'rails/all'
require 'csv'

Bundler.require(*Rails.groups)

module Task
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :test_unit, fixture: false, fixture_replacement: :factory_girl
    end

    config.timezone = 'Samara'
  end
end
