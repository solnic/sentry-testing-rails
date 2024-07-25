module Sentry
  module Testing
    module_function

    def faraday
      @faraday ||= ::Faraday::Connection.new("https://api.github.com") do |faraday|
        faraday.adapter :http
      end
    end
  end
end
