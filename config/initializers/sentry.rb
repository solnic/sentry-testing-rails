# frozen_string_literal: true

require "faraday"

Sentry.init do |config|
  config.dsn = "https://3b90be6e9f8e7a02154877e541760273@o4507656852602880.ingest.us.sentry.io/4507656852865024"
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
  # Set profiles_sample_rate to profile 100%
  # of sampled transactions.
  # We recommend adjusting this value in production.
  config.profiles_sample_rate = 1.0

  config.enabled_patches << :faraday

  config.logger = Logger.new($stdout)
end
