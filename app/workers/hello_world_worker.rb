class HelloWorldWorker
  include Sidekiq::Worker

  sidekiq_options queue: "simulated_workload"

  def perform
    puts "Hello World from Sidekiq!"

    # Simulate some processing time
    process_time = rand(1..5)
    sleep(process_time)

    # Simulate some CPU-intensive work
    result = 0
    10_000.times { result += rand(100) }

    # You can add a Sentry capture here to test the integration
    # Sentry.capture_message(
    #   "Hello World job processed", extra: {
    #     process_time: process_time,
    #     result: result
    #   }
    # )

    puts "Job completed after #{process_time} seconds with result: #{result}"
  end
end
