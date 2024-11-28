# frozen_string_literal: true

class HelloController < ApplicationController
  include Sentry::Testing

  skip_before_action :verify_authenticity_token

  def cache
    Rails.cache.write("my_cache_key", "my_cache_value")

    head :ok
  end

  def heavy
    transaction = Sentry.get_current_scope.get_transaction

    transaction.with_child_span(op: :process_items, description: "heavy.work") do |_span|
      3.times.map do |i|
        Thread.new do
          Thread.current.name = "thread-bar-#{i}"

          heavy_work
        end
      end.map(&:join)
    end

    head :ok
  end

  def heavy_sp
    3.times.map do |i|
      heavy_work
    end

    head :ok
  end

  def repo
    repo = faraday.get("/repos/getsentry/sentry-ruby")

    render json: repo.body
  end

  def error_with_attachment
    attachment = Sentry.add_attachment(path: __FILE__, content_type: "text/plain")
    # attachment = Sentry.add_attachment(filename: "test.txt", bytes: "hello world")

    puts attachment.to_envelope_headers
    puts attachment.payload

    Sentry.capture_message("This one has attachments!")

    head :ok
  end

  def error_with_locals
    var_one = 0
    var_two = 2

    var_two / var_one
  end

  def error_faraday
    payload = JSON.dump({foo: "bar"})
    # payload = {foo: "bar"}
    headers = {"Content-Type" => "application/json"}

    response = faraday_local.post("/crash", payload, headers)

    puts response.status

    head :ok
  end

  def crash
    raise "Well nope!"
  end

  def schedule_hello_world
    HelloWorldWorker.perform_async
    render json: { message: "Hello World job scheduled" }
  end

  def error_excon
    connection = Excon.new('https://api.github.com')
    payload = JSON.dump({foo: "bar"})
    headers = {"Content-Type" => "application/json"}

    response = connection.post(
      path: '/crash',
      body: payload,
      headers: headers
    )

    puts response.status

    head :ok
  rescue Excon::Error => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def repo_excon
    connection = Excon.new('https://api.github.com')
    response = connection.get(
      path: '/repos/getsentry/sentry-ruby',
      headers: { 'Content-Type' => 'application/json' }
    )

    render json: response.body
  end
end
