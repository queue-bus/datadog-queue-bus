# frozen_string_literal: true

require 'datadog'
require 'queue-bus'
require 'datadog_queue_bus/version'
require 'datadog_queue_bus/middleware'

# This module contains the implementation for tracing queue-bus work into datadog.
module DatadogQueueBus
  class << self
    # Sets the service_name that will be used when reporting queue-bus spans.
    attr_writer :service_name

    # Returns the service name that is used when reporting queue-bus spans.
    def service_name
      @service_name ||= 'queue-bus'
    end
  end
end
