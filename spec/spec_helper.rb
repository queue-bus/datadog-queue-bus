# frozen_string_literal: true

require 'bundler/setup'
require 'datadog-queue-bus'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    # Clear out whatever might be in here.
    DatadogQueueBus.service_name = nil
  end
end
