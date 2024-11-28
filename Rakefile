# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

require "rake"
require "rake/task"

module Sentry
  module Rake
    module Task
      def execute(args = nil)
        if Sentry.initialized? && !Sentry.configuration.skip_rake_integration
          transaction = Sentry.start_transaction(name: "rake #{name}", op: "rake")
        end

        super
      ensure
        transaction&.finish
      end
    end
  end
end

Rake::Task["db:migrate"].extend(Sentry::Rake::Task)
