require 'clockwork'
require './config/boot'
require './config/environment'

include Clockwork

configure do |config|
  config[:tz] = 'Samara'
end

# TODO: use sidekiq jobs
every(1.day, 'daily_update.job', at: '00:00') { DailyUpdateService.perform }
