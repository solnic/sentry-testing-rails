# frozen_string_literal: true

require "faraday"

Sentry.init do |config|
  config.dsn = "https://52af1936903e5cf975440e0361d81396@o447951.ingest.us.sentry.io/4508103969865728"
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  config.enabled_patches += %i[excon sidekiq_cron]

  config.rails.tracing_subscribers = [Sentry::Rails::Tracing::ActiveSupportSubscriber]

  config.traces_sample_rate = 1.0

  config.traces_sampler = lambda do |context|
    true
  end

  config.profiles_sample_rate = 1.0
  config.profiler_class = Sentry::Vernier::Profiler
end
