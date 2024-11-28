module Sentry
  module Testing
    module_function

    module Bar
      module Foo
        def self.foo
          10_000.to_i.times { 2 * 2 }
        end
      end

      def self.bar
        Foo.foo
        # sleep 0.1
      end
    end

    def faraday
      @faraday ||= ::Faraday::Connection.new("https://api.github.com") do |faraday|
        faraday.adapter :http
      end
    end

    def faraday_local
      @faraday_local ||= ::Faraday::Connection.new("http://localhost:3001") do |faraday|
        faraday.adapter :http
      end
    end

    def heavy_work
      Bar.bar
    end
  end
end
