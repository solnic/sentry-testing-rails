class HelloController < ApplicationController
  def repo
    repo = Sentry::Testing.faraday.get("/repos/getsentry/sentry-ruby")

    render json: repo.body
  end
end
