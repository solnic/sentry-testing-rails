class TestCronWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'simulated_workload'

  def perform
    Rails.logger.info "TestCronWorker running at #{Time.current}"
    puts "TestCronWorker running at #{Time.current}"

    # # Simulate multi-threaded workload
    # threads = []
    # 5.times do |i|
    #   threads << Thread.new do
        # Simulate CPU-intensive work
        result = 0
        10_000_000.times { result += rand }

        # Simulate I/O work with sleep
        sleep(rand * 0.1)

        # Rails.logger.info "Thread #{i} completed with result: #{result}"
    #   end
    # end

    # Wait for all threads to complete
    # threads.each(&:join)
  end
end
